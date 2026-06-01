import json

# 1. Point Python to the exact file name sitting in your folder
FILE_NAME = "raw_data.json"

print(f"⏳ Attempting to open {FILE_NAME} blindly...")

try:
    # 2. Python opens the file directly from the hard drive
    with open(FILE_NAME, 'r', encoding='utf-8') as file:
        data = json.load(file)
        
    print("✅ Success! Python read the file perfectly.")
    print(f"📊 The data type is: {type(data)}")
    
    # Just print the first 500 characters to prove it worked, without flooding the terminal
    raw_text = str(data)
    print(f"📝 Preview: {raw_text[:500]}...")

except FileNotFoundError:
    print(f"❌ Error: Python could not find '{FILE_NAME}'. Make sure it is in the scraper folder!")
except json.JSONDecodeError:
    print("❌ Error: The file is not valid JSON. Make sure you saved the clean Response from the browser.")