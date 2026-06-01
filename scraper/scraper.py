import hashlib
import requests
import io
import re
from bs4 import BeautifulSoup
from pypdf import PdfReader
import time
import json

# Configurations
BACKEND_URL = "http://127.0.0.1:8787/api/index"
NAVTTC_NOTIFICATIONS_URL = "https://navttc.gov.pk/notifications/"

def upload_to_vector_db(text_chunks, source_title, source_url):
    """Pushes verified text blocks with throttled requests and strict metadata limits."""
    success_count = 0
    
    for chunk in text_chunks:
        # Create a clean ID
        chunk_id = generate_stable_id(chunk)
        
        # FIX: Metadata must be < 10KB. 
        # We only send the title, not the full massive URL if it's too long.
        metadata = {
            "source": source_title[:100]  # Truncate title to 100 chars
        }
        
        payload = {
            "id": chunk_id,
            "text": chunk,
            "metadata": metadata
        }
        
        try:
            # Send to backend
            response = requests.post(BACKEND_URL, json=payload, timeout=15)
            
            if response.status_code == 200:
                success_count += 1
                # FIX: Throttle the request to prevent the '500' server crash
                time.sleep(0.2) 
            else:
                # Print specific error without crashing the whole scraper
                print(f"DEBUG: Rejected '{source_title[:20]}'. Status: {response.status_code}")
                
        except Exception as e:
            print(f"DEBUG: Connection error for {source_title}: {str(e)}")
            time.sleep(1) # Wait longer if connection fails
            
    if success_count > 0:
        print(f"   ✅ Synced: {success_count} chunks")

def contains_nastaliq(text_chunk):
    """Checks if a string contains standard Nastaliq (Urdu/Arabic) characters."""
    nastaliq_pattern = re.compile(r'[\u0600-\u06FF\u0750-\u077F\uFB50-\uFDFF\uFE70-\uFEFF]')
    if nastaliq_pattern.search(text_chunk):
        return True
    return False

def generate_stable_id(text_chunk):
    """Generates a unique, reproducible ID using the text's MD5 hash to prevent duplicates."""
    return hashlib.md5(text_chunk.encode('utf-8')).hexdigest()

def clean_text(text):
    """Cleans up horizontal white spaces but preserves structural line breaks for tables."""
    text = re.sub(r'[ \t]+', ' ', text)
    text = re.sub(r'\n+', '\n', text)
    return text.strip()

def chunk_text(text, max_chars=450):
    """Splits text into chunks using punctuation and line breaks, filtering out true corruption."""
    sentences = re.split(r'(?<=[.!?\n])\s+', text)
    chunks = []
    current_chunk = ""

    for sentence in sentences:
        sentence = sentence.strip()
        if not sentence:
            continue
            
        if len(current_chunk) + len(sentence) <= max_chars:
            current_chunk += " " + sentence if current_chunk else sentence
        else:
            if current_chunk:
                chunks.append(current_chunk.strip())
            current_chunk = sentence
            
    if current_chunk:
        chunks.append(current_chunk.strip())
        
    valid_chunks = []
    for chunk in chunks:
        if '\ufffd' in chunk or 'uni' in chunk.lower() or len(chunk) < 20:
            continue
            
        valid_chunks.append(chunk)
        
    return valid_chunks

def extract_text_from_online_pdf(pdf_url):
    """Downloads a PDF and extracts text, now with error reporting."""
    try:
        response = requests.get(pdf_url, headers={'User-Agent': 'Mozilla/5.0'}, timeout=15)
        if response.status_code != 200:
            print(f"DEBUG: Failed to download PDF. Status Code: {response.status_code}")
            return ""
        
        pdf_file = io.BytesIO(response.content)
        reader = PdfReader(pdf_file)
        
        extracted_text = ""
        for page in reader.pages:
            text = page.extract_text()
            if text:
                extracted_text += text + "\n"
        
        # DEBUG: Tell us how much text we actually got
        print(f"DEBUG: Extracted {len(extracted_text)} characters from {pdf_url.split('/')[-1]}")
        return extracted_text
    except Exception as e:
        print(f"DEBUG: Error processing PDF: {str(e)}")
        return ""

def upload_to_vector_db(text_chunks, source_title, source_url):
    """Pushes verified text blocks into the Cloudflare Worker backend."""
    success_count = 0
    skipped_count = 0
    
    for chunk in text_chunks:
        if contains_nastaliq(chunk):
            skipped_count += 1
            continue 
            
        chunk_id = generate_stable_id(chunk)
        payload = {
            "id": chunk_id,
            "text": chunk,
            "metadata": {"source": source_title, "url": source_url}
        }
        try:
            response = requests.post(BACKEND_URL, json=payload, timeout=10)
            if response.status_code == 200:
                success_count += 1
            else:
                # DEBUG: See if Cloudflare is rejecting your data
                print(f"DEBUG: Cloudflare rejected upload. Status: {response.status_code}, Msg: {response.text}")
        except Exception as e:
            print(f"DEBUG: Connection error: {str(e)}")
            
    if success_count > 0:
        print(f"   ✅ Synced: {success_count} chunks")

def run_automated_pipeline():
    print(f"🔍 Scanning NAVTTC Notification Board: {NAVTTC_NOTIFICATIONS_URL}")
    try:
        headers = {'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64)'}
        web_response = requests.get(NAVTTC_NOTIFICATIONS_URL, headers=headers, timeout=15)
        if web_response.status_code != 200:
            print("❌ Failed to reach NAVTTC Website.")
            return
        
        soup = BeautifulSoup(web_response.text, 'html.parser')
        
        # --- PHASE 1: WEBPAGE LAYOUT SCRAPING ---
        print("\n🌐 Extracting text updates directly from HTML tables...")
        web_announcements = []
        for row in soup.find_all(['tr', 'td', 'li']):
            txt = row.get_text().strip()
            if any(k in txt for k in ["Notification", "Batch", "PMYSDP", "Result", "List", "Course", "Assessment"]):
                clean_txt = clean_text(txt)
                if clean_txt and len(clean_txt) > 35 and clean_txt not in web_announcements:
                    web_announcements.append(clean_txt)
        
        if web_announcements:
            print(f" 📝 Found {len(web_announcements)} text lines. Processing...")
            for idx, announcement in enumerate(web_announcements):
                web_chunks = chunk_text(announcement, max_chars=400)
                if web_chunks:
                    upload_to_vector_db(web_chunks, source_title=f"Portal Update #{idx}", source_url=NAVTTC_NOTIFICATIONS_URL)

        # --- PHASE 2: AUTOMATED DEEP PDF PROCESSING ---
        print("\n🎯 Discovering circular attachment files...")
        pdf_links = []
        for anchor in soup.find_all('a', href=True):
            href = anchor['href']
            if href.endswith('.pdf'):
                title = anchor.get_text().strip() or href.split('/')[-1]
                # Avoid duplicate links
                if (title, href) not in pdf_links:
                    pdf_links.append((title, href))
        
        print(f" 📂 Found {len(pdf_links)} PDF circulars online. Starting automated inspection...")
        
        for idx, (title, url) in enumerate(pdf_links, 1):
            full_url = url if url.startswith('http') else f"https://navttc.gov.pk{url}"
            print(f" [{idx}/{len(pdf_links)}] Analyzing: {title[:50]}...")
            
            raw_pdf_text = extract_text_from_online_pdf(full_url)
            if not raw_pdf_text.strip():
                continue
                
            cleaned_pdf_text = clean_text(raw_pdf_text)
            pdf_chunks = chunk_text(cleaned_pdf_text, max_chars=450)
            
            if pdf_chunks:
                upload_to_vector_db(pdf_chunks, source_title=f"PDF Circular: {title}", source_url=full_url)
                
        print("\n🎉 Pipeline execution completed successfully!")
        
    except Exception as e:
        print(f"💥 Pipeline failure: {str(e)}")

if __name__ == "__main__":
    run_automated_pipeline()