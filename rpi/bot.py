import cv2
from picamera2 import Picamera2, Preview
import requests
from ultralytics import YOLO
import time
from gpiozero import LED

picam2 = Picamera2()
picam2.preview_configuration.main.size = (1280, 1280)
picam2.preview_configuration.main.format = "RGB888"
picam2.preview_configuration.align()
picam2.start()

# Telegram bot token
BOT_TOKEN = "7301257374:AAHhcYhBFN8s1EgSVKQzC51D4w8p4pyP-MM"

def get_chat_id():
    url = f"https://api.telegram.org/bot{BOT_TOKEN}/getUpdates"
    response = requests.get(url).json()

    if "result" in response and len(response["result"]) > 0:
        chat_id = response["result"][-1]["message"]["chat"]["id"]
        return chat_id
    else:
        print("No chat ID found. Send a message to the bot first!")
        return None

def send_telegram_message(message):
    chat_id = get_chat_id()
    if not chat_id:
        return

    url = f"https://api.telegram.org/bot{BOT_TOKEN}/sendMessage"
    payload = {"chat_id": chat_id, "text": message}
    requests.post(url, json=payload)

def send_telegram_photo(photo_path):
    chat_id = get_chat_id()
    if not chat_id:
        return

    url = f"https://api.telegram.org/bot{BOT_TOKEN}/sendPhoto"
    with open(photo_path, "rb") as photo:
        files = {"photo": photo}
        requests.post(url, data={"chat_id": chat_id}, files=files)

# Load YOLOv8 model
model = YOLO("best.onnx")
elephant_detected = False
led = LED(17)

while True:
    frame = picam2.capture_array()
    # Run YOLOv8 detection
    results = model(frame)

    for result in results:
        for box in result.boxes:
            class_id = int(box.cls[0])
            class_name = model.names[class_id]

            if class_name.lower() == "elephant":
                x1, y1, x2, y2 = map(int, box.xyxy[0])
                cv2.rectangle(frame, (x1, y1), (x2, y2), (0, 255, 0), 2)
                cv2.putText(frame, class_name, (x1, y1 - 10), cv2.FONT_HERSHEY_SIMPLEX, 0.5, (0, 255, 0), 2)

                if not elephant_detected:
                    send_telegram_message("🚨 Elephant detected!")
                    
                    # Save the detected frame
                    photo_path = "elephant_detected.jpg"
                    cv2.imwrite(photo_path, frame)

                    # Send the saved image to Telegram
                    send_telegram_photo(photo_path)
                    led.on()
                    elephant_detected = True  # Prevent spam
                    
                    time.sleep(20)

                    led.off()
                    elephant_detected = False
                    
                    continue
#    cv2.imshow("YOLOv8 Elephant Detection", frame)

#    if cv2.waitKey(1) & 0xFF == ord("q"):
#        break

cap.release()
cv2.destroyAllWindows()

