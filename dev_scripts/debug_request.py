import requests
import json

base_url = "http://localhost"

print("检查请求的实际处理路径")
print("="*50)

# 教师登录
session = requests.Session()
login_data = {
    "username": "T2021001",
    "password": "123456",
    "rememberMe": "false"
}
response = session.post(f"{base_url}/login", data=login_data)
print(f"登录成功")

# 查看自己的课程
print("\n请求查看自己的课程 C001")
response = session.post(f"{base_url}/teacher/course/students/list", data={"cno": "C001"})
print(f"状态码: {response.status_code}")
print(f"响应头:")
for key, value in response.headers.items():
    print(f"  {key}: {value}")
print(f"响应内容: {response.text[:500]}")

# 查看别人的课程
print("\n请求查看别人的课程 C002")
response = session.post(f"{base_url}/teacher/course/students/list", data={"cno": "C002"})
print(f"状态码: {response.status_code}")
print(f"响应内容: {response.text[:500]}")