import requests
import json

base_url = "http://localhost"

print("测试：检查当前登录用户信息")
print("="*50)

# 教师登录
session = requests.Session()
login_data = {
    "username": "T2021001",
    "password": "123456",
    "rememberMe": "false"
}
response = session.post(f"{base_url}/login", data=login_data)
print(f"登录响应: {response.json().get('msg')}")

# 检查Session信息
print("\n检查Session信息（访问教师首页）")
response = session.get(f"{base_url}/teacher/index?tno=T2021001")
print(f"状态码: {response.status_code}")

# 测试查看学生成绩（带上tno参数）
print("\n测试查看学生成绩")
response = session.post(f"{base_url}/teacher/course/students/list", data={"cno": "C002", "tno": "T2021001"})
print(f"状态码: {response.status_code}")
data = response.json()
print(f"学生数量: {data.get('total', 0)}")

# 测试用另一个教师的身份查看
print("\n测试用教师 T2021002 查看")
session2 = requests.Session()
login_data2 = {
    "username": "T2021002",
    "password": "123456",
    "rememberMe": "false"
}
response = session2.post(f"{base_url}/login", data=login_data2)
print(f"登录响应: {response.json().get('msg')}")

response = session2.post(f"{base_url}/teacher/course/list", data={"tno": "T2021002"})
data = response.json()
print(f"教师 T2021002 的课程:")
for course in data.get('rows', []):
    print(f"  {course.get('cno')} - {course.get('cname')}")

response = session2.post(f"{base_url}/teacher/course/students/list", data={"cno": "C002"})
data = response.json()
print(f"\n查看 C002 的学生数量: {data.get('total', 0)}")