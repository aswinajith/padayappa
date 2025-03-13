from ultralytics import YOLO

# Load the YOLO11 model
model = YOLO("best.pt")

# Export the model to NCNN format
model.export(format="ncnn")
