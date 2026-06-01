export default {
  async fetch(request, env) {
    const url = new URL(request.url);

    // 1. Handle CORS Preflight Requests (Crucial for mobile and web apps)
    if (request.method === "OPTIONS") {
      return new Response(null, {
        headers: {
          "Access-Control-Allow-Origin": "*",
          "Access-Control-Allow-Methods": "GET, POST, OPTIONS",
          "Access-Control-Allow-Headers": "Content-Type",
        },
      });
    }

    // CORS Headers for standard responses
    const corsHeaders = {
      "Access-Control-Allow-Origin": "*",
      "Content-Type": "application/json",
    };

    try {
      // 2. ENDPOINT: INGEST DATA FROM PYTHON SCRAPER
      if (url.pathname === "/api/index" && request.method === "POST") {
        const body = await request.json();
        const { id, text, metadata } = body;

        if (!id || !text) {
          return new Response(JSON.stringify({ error: "Missing id or text" }), { status: 400, headers: corsHeaders });
        }

        const embeddingResponse = await env.AI.run("@cf/baai/bge-small-en-v1.5", {
          text: [text],
        });
        const values = embeddingResponse.data[0];

        await env.VECTORIZE.upsert([
          {
            id: id,
            values: values,
            metadata: { 
              text: text,
              source: metadata?.source || "NAVTTC Document"
            },
          },
        ]);

        return new Response(JSON.stringify({ success: true, message: `Chunk ${id} indexed successfully!` }), { status: 200, headers: corsHeaders });
      }

      // 3. ENDPOINT: INTERACTIVE CHAT (HYBRID RAG PIPELINE)
      if (url.pathname === "/api/chat" && request.method === "POST") {
        console.log("📥 [CHECKPOINT 1] Received POST request on /api/chat");
        
        const body = await request.json();
        const { question } = body;

        if (!question) {
          console.log("⚠️ [WARNING] Request rejected: Missing question parameter.");
          return new Response(JSON.stringify({ error: "Missing question" }), { status: 400, headers: corsHeaders });
        }

        // Truncate massively long inputs to prevent Vector Embedding crashes
        const safeQuestion = question.length > 1000 ? question.substring(0, 1000) : question;

        // CHATGPT-STYLE EXIT CONVERSATION HANDLER
        const cleanQuestion = safeQuestion.trim().toLowerCase().replace(/[.,\/#!$%\^&\*;:{}=\-_`~()\?]/g,"");
        const exitPhrases = ["exit", "bye", "goodbye", "quit", "allah hafiz", "khuda hafiz", "خدا حافظ", "اللہ حافظ"];
        
        if (exitPhrases.includes(cleanQuestion)) {
          console.log(`👋 [EXIT] User sent exit phrase: "${cleanQuestion}". Ending conversation.`);
          return new Response(JSON.stringify({ 
            answer: "😊 Thank you so much for the conversation! See you again soon. It was an absolute pleasure helping you, and I am always glad to support you! Take care and best of luck! 👋",
            contextUsed: []
          }), { status: 200, headers: corsHeaders });
        }

        // STEP A: Fetch unstructured semantic data from Vector Database
        console.log("⚡ [HYBRID RAG] Fetching Vector Embeddings...");
        const questionEmbedding = await env.AI.run("@cf/baai/bge-small-en-v1.5", {
          text: [safeQuestion],
        });
        const queryVector = questionEmbedding.data[0];

        const vectorMatches = await env.VECTORIZE.query(queryVector, {
          topK: 3,
          returnValues: false,
          returnMetadata: true,
        });

        let contextText = "";
        if (vectorMatches.matches && vectorMatches.matches.length > 0) {
          contextText = vectorMatches.matches
            .map((match) => match.metadata.text)
            .join("\n\n");
        }

        // STEP B: Fetch dynamic structured data from D1 SQL Database based on keywords
        console.log("⚡ [HYBRID RAG] Scanning question keywords for SQL matching...");
        try {
          // Pull lightweight lookup references
          const dbDistricts = await env.navttc_db.prepare("SELECT id, name FROM districts").all();
          const dbTrades = await env.navttc_db.prepare("SELECT id, name FROM trades").all();

          let matchedDistrictIds = [];
          let matchedTradeIds = [];

          // Flag explicit requests for lists
          const asksForList = cleanQuestion.includes("list") || cleanQuestion.includes("show") || cleanQuestion.includes("tamam") || cleanQuestion.includes("kon kon");

          dbDistricts.results.forEach(d => {
            if (cleanQuestion.includes(d.name.toLowerCase())) matchedDistrictIds.push(d.id);
          });

          dbTrades.results.forEach(t => {
            // Match subsegments (e.g. user asks for "web dev", matches database "Web Development")
            const normalizedTrade = t.name.toLowerCase();
            if (cleanQuestion.includes(normalizedTrade) || normalizedTrade.includes(cleanQuestion)) {
              matchedTradeIds.push(t.id);
            }
          });

          // Build dynamic SQL query conditions based on extraction
          let queryConditions = [];
          let queryParams = [];

          if (matchedDistrictIds.length > 0) {
            queryConditions.push(`i.district_id IN (${matchedDistrictIds.map(() => '?').join(',')})`);
            queryParams.push(...matchedDistrictIds);
          }
          if (matchedTradeIds.length > 0) {
            queryConditions.push(`co.trade_id IN (${matchedTradeIds.map(() => '?').join(',')})`);
            queryParams.push(...matchedTradeIds);
          }

          // UPDATED: Added co.stipend_eligible and co.hostel_available
          let sqlQuery = `
            SELECT i.name as institute_name, i.address, d.name as district_name, t.name as course_name, co.stipend_eligible, co.hostel_available 
            FROM course_offerings co
            JOIN institutes i ON co.institute_id = i.id
            JOIN districts d ON i.district_id = d.id
            JOIN trades t ON co.trade_id = t.id
          `;

          // If specific keywords matched or a list was requested, construct the query target
          if (queryConditions.length > 0) {
            sqlQuery += " WHERE " + queryConditions.join(" AND ");
          } else if (!asksForList) {
            // Force empty results if user is talking about something unrelated to structured lists
            sqlQuery += " WHERE 1=0"; 
          }

          // Add a protective context cap limit
          sqlQuery += " LIMIT 15";

          const sqlStatement = env.navttc_db.prepare(sqlQuery).bind(...queryParams);
          const { results } = await sqlStatement.all();

          // UPDATED: Mapping the 1/0 integers to Yes/No strings for the AI context
          if (results && results.length > 0) {
            const sqlContextStr = results.map(r => {
  const stipendStatus = r.stipend_eligible === 1 ? "Yes" : "No";
  const hostelStatus = r.hostel_available === 1 ? "Yes" : "No";
  // Updated for cleaner appearance in the prompt:
  return `- Institute: ${r.institute_name} | Location: ${r.address}, ${r.district_name} | Course: ${r.course_name} | Stipend: ${stipendStatus} | Hostel: ${hostelStatus}`;
}).join("\n");
            
            contextText += "\n\n[Official SQL Database Records]:\n" + sqlContextStr;
          }
        } catch (sqlErr) {
          console.error("SQL Extraction Error: ", sqlErr.message);
        }

        // THE FINAL HARDENED SYSTEM PROMPT WITH FEATURING RULES (UNCHANGED)
        const systemPrompt = `You are a warm, authentic, and knowledgeable AI Academic Advisor for NAVTTC (National Vocational and Technical Training Commission). Your goal is to guide users naturally and professionally.

Follow these strict conversational rules to handle edge cases flawlessly:

1. PERSONA & TONE: Speak like a helpful human mentor. Never use technical jargon like "Based on the provided context...", "According to the database... and FACTUAL MEMORY", or "I see reference materials." Just smoothly weave the facts into your answer.

2. NO PHANTOM PERSONALIZATION & NO PLACEHOLDERS: Never invent or assume the user's name. NEVER use placeholders like "[insert name]", "[link]", or "[Date]". If you don't know a specific detail, just explain what you *do* know. 

3. INTENT BOUNDARY (STUDENT VS. INSTITUTE): Treat the user as a Trainee/Student looking for courses, unless they explicitly state they are an institute owner. 

4. STRICT BILINGUAL MATCHING (THE CHAMELEON RULE): You must analyze the language of the user's prompt and match it 100%. 
- If the user ask question in English, reply 100% in English(e.g., do not say "Mehboob","Mehbooba","pare","larky","Aray","khair!") in English response. 
- If the user ask question in Roman Urdu(e.g., "mujhe", "karni", "yar","bhai", "fees", "kitni hai", "btao", "kiya"), your entire response must be in natural, conversational Roman Urdu. Do NOT mix English sentences into a Roman Urdu, and do not leak Roman Urdu into an English response.

5. THE GRACEFUL FALLBACK (MISSING DATA): If the exact details (like a phone number, exact duration, or specific date) are NOT in the Factual Memory, do not hallucinate. Instead of pasting a robotic disclaimer at the end, smoothly integrate this meaning into your natural conversation: "I don't have the exact [missing detail] in my current records, but I highly recommend checking the official NAVTTC Live Notifications Portal (https://navttc.gov.pk/notifications/) or contacting the institute directly for the most accurate information."

6. 100% FREE EDUCATION POLICY (FEES): If the user asks about course fees, admission charges, or monthly installments, you must explicitly state that all NAVTTC training courses are entirely FREE of cost, funded by the Government of Pakistan. There are no tuition fees or hidden charges. (Translate this into the user's language).
- If they ask about installments specifically, you MUST state that because the courses are completely free, installments are not required and do not exist. Never tell a user they can pay in installments.

7. NO HALLUCINATIONS: Never invent user names (e.g., do not say "Aamir","Mehboob","Mehboob","pare","larky","Aray","khair!"). Start directly with your answer. Never invent institutes that are not in the Factual Memory.
YOUR FACTUAL MEMORY FOR THIS QUESTION:
${contextText}`;

        // Fire up Llama 3 with streaming enabled
        console.log("🚀 [LLM] Executing final generation streaming connection...");
        const aiResponse = await env.AI.run("@cf/meta/llama-3-8b-instruct", {
          messages: [
            { role: "system", content: systemPrompt },
            { role: "user", content: safeQuestion },
          ],
          stream: true, 
          max_tokens: 1024 
        });

        // Send the raw stream directly to the client with live streaming headers
        return new Response(aiResponse, { 
          status: 200, 
          headers: { 
            "Access-Control-Allow-Origin": "*",
            "Access-Control-Allow-Methods": "GET, POST, OPTIONS",
            "Access-Control-Allow-Headers": "Content-Type",
            "Content-Type": "text/event-stream",
            "Cache-Control": "no-cache",
            "Connection": "keep-alive"
          } 
        });
      }

      // 4. Fallback route for invalid URLs
      console.log(`⚠️ [WARNING] 404 Route hit: Unknown URL path requested: ${url.pathname}`);
      return new Response(JSON.stringify({ error: "Endpoint not found" }), { 
        status: 404, 
        headers: { ...corsHeaders, "Content-Type": "application/json" } 
      });

    } catch (err) {
      console.error("💥 [CRITICAL RUNTIME EXCEPTION]");
      console.error(err.stack || err.message || err);
      
      return new Response(JSON.stringify({ error: err.message }), { 
        status: 500, 
        headers: { ...corsHeaders, "Content-Type": "application/json" } 
      });
    }
  },
};