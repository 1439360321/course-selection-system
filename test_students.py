import requests
import json

base_url = "http://localhost"

print("测试查看学生接口")
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

# 测试查看学生接口（模拟前端调用）
print("\n测试查看学生接口：")
response = session.post(f"{base_url}/teacher/course/students/list", data={"cno": "C001", "pageNum": 1, "pageSize": 10})
print(f"状态码: {response.status_code}")
print(f"响应内容: {response.text}")

# 测试获取学生页面
print("\n测试获取学生页面：")
response = session.get(f"{base_url}/teacher/course/students?tno=T2021001&cno=C001")
print(f"状态码: {response.status_code}")
print(f"响应内容类型: {response.headers.get('Content-Type', '')}")