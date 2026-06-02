import streamlit as st
import requests
import json

# --- CONFIGURATION ---
BACKEND_URL = "https://backend-ai.amjadanjum05.workers.dev/api/chat"

st.set_page_config(page_title="NAVTTC Academic Advisor", page_icon="🎓", layout="centered")

# --- UI HEADER ---
st.title("🎓 NAVTTC Academic Advisor")
st.markdown("---")

# --- SESSION STATE INITIALIZATION ---
if "messages" not in st.session_state:
    st.session_state.messages = [
        {"role": "assistant", "content": "Assalam-o-Alaikum! I am your NAVTTC Academic Advisor. How can I help you today? (Aap Roman Urdu ya English me sawal pooch sakte hain)"}
    ]

# --- DISPLAY CHAT HISTORY ---
for message in st.session_state.messages:
    with st.chat_message(message["role"]):
        st.markdown(message["content"])

# --- USER INPUT HANDLING ---
if user_input := st.chat_input("Ask about courses, stipends, or locations..."):
    # 1. Display user message immediately
    st.session_state.messages.append({"role": "user", "content": user_input})
    with st.chat_message("user"):
        st.markdown(user_input)

    # 2. Query the Hybrid RAG Backend via live stream
    with st.chat_message("assistant"):
        response_placeholder = st.empty()
        response_placeholder.markdown("*Thinking...*")
        # Generator function to read streaming chunks safely from the backend
        def stream_backend_response():
            try:
                payload = {"question": user_input}
                # Setting stream=True keeps the connection pipeline open
                with requests.post(BACKEND_URL, json=payload, stream=True, timeout=30) as response:
                    if response.status_code != 200:
                        yield f"❌ Error: Backend returned status code {response.status_code}"
                        return
                    
                    # Read chunks line-by-line as they arrive from Cloudflare
                    for line in response.iter_lines():
                        if line:
                            decoded_line = line.decode('utf-8').strip()
                            
                            # Handle Server-Sent Events (SSE) formatting if present
                            if decoded_line.startswith("data:"):
                                content = decoded_line.replace("data:", "").strip()
                                if content == "[DONE]":
                                    break
                                try:
                                    data_json = json.loads(content)
                                    yield data_json.get("response", "")
                                except json.JSONDecodeError:
                                    yield content
                            else:
                                # Handle raw word chunks directly
                                yield decoded_line + " "
                                
            except requests.exceptions.RequestException:
                yield "❌ Unable to connect to the backend server. Make sure your Cloudflare Worker is running locally (`npx wrangler dev`)."

        # Pass the generator directly to Streamlit's write_stream for typewriter style UI
        full_response = st.write_stream(stream_backend_response())
        st.session_state.messages.append({"role": "assistant", "content": full_response})