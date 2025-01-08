import requests

task_id = "0193ee7b-1078-7a74-b650-f12fa1f2c06d"
API="msy_UHB6LVZqUdTmETLWZXlqNQ6tv9fF5ydQkrvP"
headers = {
    "Authorization": f"Bearer {API}"
}

response = requests.get(
    f"https://api.meshy.ai/openapi/v1/image-to-3d/{task_id}",
    headers=headers,
)
response.raise_for_status()
print(response.json())
