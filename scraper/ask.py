import requests

CHAT_URL = "http://127.0.0.1:8787/api/chat"

# Ask a specific question that depends on the data we just indexed
query = {"question": "What is the age limit for NAVTTC courses and what do I need to bring to the exam center?"}

print(f"🤔 Asking AI: {query['question']}\n")

try:
    response = requests.post(CHAT_URL, json=query)
    if response.status_code == 200:
        result = response.json()
        print("🤖 NAVTTC AI ASSISTANT ANSWER:")
        print("──────────────────────────────────────────────────")
        print(result.get("answer"))
        print("──────────────────────────────────────────────────")
        print("\n📚 Raw Context Retrieved from Vector Database:")
        for ctx in result.get("contextUsed", []):
            print(f" - {ctx}")
    else:
        print(f"❌ Error: {response.status_code} - {response.text}")
except Exception as e:
    print(f"💥 Connection failed: {str(e)}")