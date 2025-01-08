import requests
import base64

# Function to encode an image to a Base64 string
def encode_image_to_base64(image_path):
    with open(image_path, "rb") as image_file:
        return f"data:image/jpeg;base64,{base64.b64encode(image_file.read()).decode('utf-8')}"

# Input image
image_path = "i2.jpg"
base64_image = encode_image_to_base64(image_path)

# Payload
payload = {
    "image_url": base64_image,  # Using base64-encoded image
    "enable_pbr": True,
    "should_remesh": True,
    "should_texture": True
}

# API Key and URL
API_KEY = "msy_UHB6LVZqUdTmETLWZXlqNQ6tv9fF5ydQkrvP"
API_URL = "https://api.meshy.ai/openapi/v1/image-to-3d"
headers = {
    "Authorization": f"Bearer {API_KEY}"
}

# API Request
response = requests.post(API_URL, headers=headers, json=payload)

# Error Handling
response.raise_for_status()

# Process the Response
response_data = response.json()
print("Response:", response_data)

# Example: Save the returned image or model
output_file = "response_model.obj"  # Change the extension based on the API response
with open(output_file, "wb") as f:
    f.write(response.content)

print(f"3D model saved to {output_file}")
