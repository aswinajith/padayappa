from ultralytics import YOLO

# Load a pretrained YOLO11n model
model = YOLO("./best.pt")

# Run inference on the source
result = model(source=0, show=True)

for r in result:
    boxes = result.boxes
    classes = result.names
