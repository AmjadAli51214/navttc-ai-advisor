import hashlib
import requests
import time

# Syncs directly with your existing local worker configuration
BACKEND_URL = "http://127.0.0.1:8787/api/index"

# 1. This is the exact raw JSON data structure you extracted from the NSIS dropdowns
mock_dropdown_data = {
    "program": "STVP Batch-II",
    "sector": "Information Technology",
    "district": "Rawalpindi",
    "trade": "Computer Application & Office Professional",
    "institute": "Hasna Welfare and Development Organization",
    "instituteAddress": "H.No J-838, Street No:7, Near pakistan pharmacy Dhoke khabba Rawalpindi"
}

def generate_relational_sentence(data):
    """
    Transforms structured JSON entities into a single, unbreakable 
    atomic text block so the Vector DB cannot cross-contaminate fields.
    """
    sentence = (
        f"Under the {data['program']} program, the {data['institute']} "
        f"(located at the exact address: {data['instituteAddress']}) in the "
        f"{data['district']} district offers the '{data['trade']}' training course "
        f"within the {data['sector']} sector."
    )
    return sentence

def generate_deterministic_id(data):
    """
    Generates a unique hash strictly based on the core entities.
    If run multiple times, it will safely overwrite (upsert) instead of duplicating.
    """
    unique_string = f"{data['program']}_{data['district']}_{data['institute']}_{data['trade']}"
    return hashlib.md5(unique_string.encode('utf-8')).hexdigest()

def inject_test_data():
    print("⏳ Generating atomic declaration from dropdown data...")
    flat_text = generate_relational_sentence(mock_dropdown_data)
    chunk_id = generate_deterministic_id(mock_dropdown_data)
    
    print(f"📝 Generated Sentence:\n\"{flat_text}\"\n")
    
    payload = {
        "id": chunk_id,
        "text": flat_text,
        "metadata": {
            "source": f"NSIS Portal Dropdown: {mock_dropdown_data['program']}"
        }
    }
    
    print(f"🚀 Dispatching test payload to backend: {BACKEND_URL}")
    try:
        response = requests.post(BACKEND_URL, json=payload, timeout=10)
        if response.status_code == 200:
            print(f"✅ [SUCCESS] Status 200: Test chunk {chunk_id} successfully indexed in Vectorize!")
        else:
            print(f"❌ [REJECTED] Status {response.status_code}: {response.text}")
    except Exception as e:
        print(f"💥 [CONNECTION ERROR] Could not reach local worker: {str(e)}")

if __name__ == "__main__":
    inject_test_data()