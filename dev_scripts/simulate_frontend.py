import requests
import json

base_url = "http://localhost"

print("模拟前端页面加载流程")
print("="*50)

# 1. 教师登录
print("\n[步骤1] 教师登录")
session = requests.Session()
login_data = {
    "username": "T2021001",
    "password": "123456",
    "rememberMe": "false"
}
response = session.post(f"{base_url}/login", data=login_data)
print(f"登录状态码: {response.status_code}")
try:
    data = response.json()
    print(f"登录响应: {json.dumps(data, ensure_ascii=False)}")
    home_url = data.get('homeUrl', '')
    print(f"跳转URL: {home_url}")
except:
    print(f"登录失败")

# 2. 访问教师首页（模拟前端页面加载）
print("\n[步骤2] 访问教师首页")
response = session.get(f"{base_url}/teacher/index?tno=T2021001")
print(f"状态码: {response.status_code}")
print(f"响应内容类型: {response.headers.get('Content-Type', '')}")

# 3. 获取教师信息（模拟页面中的AJAX请求）
print("\n[步骤3] 获取教师信息")
response = session.post(f"{base_url}/teacher/info", data={"tno": "T2021001"})
print(f"状态码: {response.status_code}")
try:
    data = response.json()
    print(f"响应: {json.dumps(data, ensure_ascii=False)}")
except Exception as e:
    print(f"解析失败: {e}")
    print(f"响应内容: {response.text[:500]}")

# 4. 获取课程列表（模拟页面中的AJAX请求）
print("\n[步骤4] 获取课程列表")
response = session.post(f"{base_url}/teacher/course/list", data={"tno": "T2021001", "pageNum": 1, "pageSize": 10})
print(f"状态码: {response.status_code}")
try:
    data = response.json()
    print(f"课程数量: {data.get('total', 0)}")
except Exception as e:
    print(f"解析失败: {e}")
    print(f"响应内容: {response.text[:500]}")

# 5. 获取学生成绩列表（模拟点击"查看学生"后的请求）
print("\n[步骤5] 获取学生成绩列表")
response = session.post(f"{base_url}/teacher/course/students/list", data={"cno": "C001", "pageNum": 1, "pageSize": 10})
print(f"状态码: {response.status_code}")
try:
    data = response.json()
    print(f"学生数量: {data.get('total', 0)}")
    print(f"响应: {json.dumps(data, ensure_ascii=False)[:500]}")
except Exception as e:
    print(f"解析失败: {e}")
    print(f"响应内容: {response.text[:500]}")

print("\n模拟完成!")