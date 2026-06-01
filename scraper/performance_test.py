import requests
import time
import sys
import json

CHAT_URL = "http://127.0.0.1:8787/api/chat"

# Active Test Query
#test_query = {"question": " do know about High Impact Training and OGDCL programs?"}
#test_query = {"question": "do you know about OGDCL programs? is it fully funded? how to apply for that program?"}
#test_query = {"question": "STVP Batch-II ke under info technology sector me Karachi east me konsa institute trade offer kar raha hai?"}
#test_query = {"question": "Rawalpindi district me total kitne institutes hain jo computer programming ya applications ki training de rahe hain?"}
# test_query = {"question": "isnavttc give me a certificate? kia hoga agr me apna course drop kr du?"}
test_query = {"question": "what are the latest notifications from navttc?contains information about specific courses and training programs that have been conducted or are scheduled to be conducted?List all the notifications with their respective dates and details."}
#test_query = {"question": "STVP Batch-II me Rawalpindi me konsa institute trade offer kar raha hai aur uska address kya hai?."}
#test_query = {"question": "Can I learn Medical Surgery and MBBS through NAVTTC in Lahore?"}
#test_query = {"question": "fetch teh contnt of ai & robotics course? tell me the date when it will start? and how much fee is there? also tell me the duration of the course?"}
#test_query = {"question": "Navttc ka woh konsa program h jis me stipend aur hostel bhe dety h? islamabad me konsa institute is program ke under computer courses offer kar raha hai? aur uska address kya hai?"}
#test_query = {"question": "Yaar ye batao NAVTTC headquarters Islamabad me kis road par hai? Aur kia software engineering course ki admission fee online credit card se pay ho sakti hai mujy roman urdu me jwaab do???"}
#test_query = {"question": "bhai software development course ki fees kitni hai? aur kiya mein installments mein de sakta hoon? jaldi btao.?Roman urdu me btao."}
#test_query = {"question": "Can you give me a list of all NAVTTC affiliated institutes located in Peshawar??"}
#test_query = {"question": "What is the exact mobile number of the principal at TechPro Islamabad, and what time does the campus open on Sundays?"}
#test_query = {"question": "I live in Islamabad but my brother is in Sialkot. Can I do a Cloud Computing course while he does Graphic Designing? List our options and the institute addresses."}
#test_query = {"question": "List all NAVTTC institutes in Rawalpindi and tell me how I can apply?which course is offered at Apex Vocational Training Centre Rawalpindi and course duration? also tell me the contact number of the institute?"}
#test_query = {"question": "Hi! can you help me? Actually me ne naya setup start kiya hai training center ka computer courses ke liye. Kya me apne institute ko register krwa sakta hu NAVTTC se? What is the step-by-step procedure for registration? Also, I want to know if there are any specific requirements or documents needed for the registration process. Lastly, how long does the registration process usually take?"}
#test_query = {"question": "Yar mujhe AI robotics karni hai par mere pas fees ke paise nahi hain, koi sasta institute hai Karachi me?"}
print("⏱️  Starting Local Performance Benchmark...")
print(f"🤔 Question: {test_query['question']}\n")

start_time = time.time()
first_token_time = None

print("🤖 AI RESPONSE (STREAMING):")
print("──────────────────────────────────────────────────")

# # 1. Show Thinking Animation
# sys.stdout.write("Thinking")
# sys.stdout.flush()

# try:
#     response = requests.post(CHAT_URL, json=test_query, stream=True, timeout=60)
    
#     if response.status_code == 200:
#         for line in response.iter_lines():
#             if line:
#                 decoded_line = line.decode('utf-8').strip()
                
#                 if decoded_line.startswith("data:"):
#                     data_content = decoded_line[5:].strip()
                    
#                     if data_content == "[DONE]":
#                         break
                    
#                     try:
#                         token_json = json.loads(data_content)
                        
#                         # Skip the final token if it only contains usage/metadata
#                         if "usage" in token_json and not token_json.get("response"):
#                             continue
                            
#                         token = token_json.get("response", "")
                        
#                         # Clear the thinking indicator the exact millisecond the first real token arrives
#                         if first_token_time is None and token.strip():
#                             first_token_time = time.time()
#                             # Backspace over "Thinking" to leave a clean paragraph start
#                             sys.stdout.write("\r" + " " * 15 + "\r")
#                             sys.stdout.flush()
                        
#                         # Print text seamlessly word-by-word
#                         sys.stdout.write(token)
#                         sys.stdout.flush()
                        
#                     except json.JSONDecodeError:
#                         pass
            
#             # 2. While waiting for the first token, animate the dots
#             if first_token_time is None:
#                 sys.stdout.write(".")
#                 sys.stdout.flush()
#                 time.sleep(0.1) # Simple pacing for the blinking effect
        
#         # Calculate total times after stream completes
#         end_time = time.time()
#         total_latency = end_time - start_time
#         time_to_first_token = first_token_time - start_time if first_token_time else total_latency
        
#         print("\n──────────────────────────────────────────────────")
#         print("📊 PERFORMANCE METRICS:")
#         print(f"⚡ Time to First Token (TTFT)  : {time_to_first_token:.2f} seconds")
#         print(f"⚡ Total Latency (Full Answer) : {total_latency:.2f} seconds")
#         print("──────────────────────────────────────────────────\n")
        
#         print("💡 Note: In streaming mode, the raw vector context blocks are processed entirely")
#         print("   on the backend to keep the connection lightning fast.")
            
#     else:
#         print(f"\n❌ Server Error ({response.status_code}): {response.text}")

# except requests.exceptions.Timeout:
#     print("\n❌ Performance Failure: The request timed out after 30 seconds.")
# except Exception as e:
#     print(f"\n💥 Connection Error: {str(e)}")


#no sleep during streaming to ensure we measure pure processing time without artificial delays
# 1. Show Thinking Text (No sleep loops needed!)
sys.stdout.write("Thinking...")
sys.stdout.flush()

try:
    response = requests.post(CHAT_URL, json=test_query, stream=True, timeout=60)
    
    if response.status_code == 200:
        # FIX: chunk_size=1 prevents Python from holding the text buffer
        for line in response.iter_lines(chunk_size=1): 
            if line:
                decoded_line = line.decode('utf-8').strip()
                
                if decoded_line.startswith("data:"):
                    data_content = decoded_line[5:].strip()
                    
                    if data_content == "[DONE]":
                        break
                    
                    try:
                        token_json = json.loads(data_content)
                        
                        if "usage" in token_json and not token_json.get("response"):
                            continue
                            
                        token = token_json.get("response", "")
                        
                        # Trigger exactly once when the first real token arrives
                        if first_token_time is None:
                            first_token_time = time.time()
                            # Clear the "Thinking..." text seamlessly
                            sys.stdout.write("\r" + " " * 15 + "\r")
                            sys.stdout.flush()
                        
                        # Print typewriter effect live
                        sys.stdout.write(token)
                        sys.stdout.flush()
                        
                    except json.JSONDecodeError:
                        pass
                        
        # Stream finished - Calculate metrics
        end_time = time.time()
        total_latency = end_time - start_time
        time_to_first_token = first_token_time - start_time if first_token_time else total_latency
        
        print("\n──────────────────────────────────────────────────")
        print("📊 PERFORMANCE METRICS:")
        print(f"⚡ Time to First Token (TTFT)  : {time_to_first_token:.2f} seconds")
        print(f"⚡ Total Latency (Full Answer) : {total_latency:.2f} seconds")
        print("──────────────────────────────────────────────────\n")
            
    else:
        print(f"\n❌ Server Error ({response.status_code}): {response.text}")

except requests.exceptions.Timeout:
    print("\n❌ Performance Failure: The request timed out.")
except Exception as e:
    print(f"\n💥 Connection Error: {str(e)}")