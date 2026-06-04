import requests
import json

base_url = "http://localhost"

print("调试：检查当前登录用户信息")
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

# 获取当前用户信息
print("\n获取当前登录用户信息")
response = session.get(f"{base_url}/system/user/profile")
print(f"状态码: {response.status_code}")
try:
    data = response.json()
    print(f"响应: {json.dumps(data, ensure_ascii=False)}")
except Exception as e:
    print(f"解析失败: {e}")
    print(f"响应内容: {response.text[:500]}")

# 检查课程 C002 的教师信息
print("\n检查课程 C002 的教师信息")
response = session.post(f"{base_url}/teacher/course/list", data={"tno": "T2021002"})  # 假设另一个教师
try:
    data = response.json()
    print(f"教师 T2021002 的课程:")
    for course in data.get('rows', []):
        print(f"  {course.get('cno')} - {course.get('cname')}")
except Exception as e:
    print(f"查询失败: {e}")