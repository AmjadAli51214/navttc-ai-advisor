# AI-Powered NAVTTC Academic Advisor (Hybrid RAG System)

A high-performance, serverless AI pipeline designed to provide context-aware, bilingual academic advising for NAVTTC students. Deployed entirely on the edge using Cloudflare Workers.

## 🧠 System Architecture

This project implements a **Hybrid RAG (Retrieval-Augmented Generation)** approach to solve the problem of LLM hallucinations in structured data environments.

* **Generative Engine:** Llama 3 (`@cf/meta/llama-3-8b-instruct`) for dynamic intent analysis and bilingual responses (English/Roman Urdu).
* **Semantic Search (Unstructured):** Cloudflare Vectorize with BGE-Small-En-v1.5 embeddings for fuzzy matching notifications and course descriptions.
* **Relational Retrieval (Structured):** Cloudflare D1 (SQLite) for real-time, deterministic data fetching (e.g., stipend availability, exact institute locations).

## 🚀 Key Technical Features

* **"Chameleon" Prompting:** The LLM dynamically shifts its tone, language, and strictness based on the user's intent and the retrieved context.
* **Hybrid Synchronization:** Custom context-mapping layers that translate raw integer database flags (like `stipend: 1`) into natural language context the LLM can reason over.
* **Edge Deployment:** Sub-2.5s Time-To-First-Token (TTFT) achieved by co-locating the Vector Index, SQL Database, and LLM Inference on Cloudflare's global edge network.
* **Zero-Downtime Data Ingestion:** Automated Python scraping scripts designed with diff-and-upsert logic to prevent database bloat and vector duplication.

## 🛠️ Tech Stack
* **Backend:** JavaScript / Cloudflare Workers
* **Data Pipeline:** Python, BeautifulSoup4, Pandas
* **Databases:** Cloudflare D1 (SQL), Cloudflare Vectorize
* **AI Models:** Meta Llama 3 (Text), BAAI BGE-Small (Embeddings)

## 🔒 Security
All sensitive datasets and environment variables are protected and ignored via strict `.gitignore` configurations.