import requests
import json

base_url = "http://localhost"

print("="*60)
print("      选课系统API测试")
print("="*60)

# 测试1：登录
print("\n[测试1] 用户登录")
print("-" * 40)
login_data = {
    "username": "admin",
    "password": "admin123"
}

try:
    session = requests.Session()
    response = session.post(f"{base_url}/login", data=login_data, timeout=5)
    print(f"状态码: {response.status_code}")
    if response.status_code == 200:
        print("登录成功!")
        cookies = session.cookies.get_dict()
        print(f"Cookies: {cookies}")
    else:
        print(f"登录失败: {response.text}")
except Exception as e:
    print(f"连接失败: {e}")
    print("\n请确保项目已启动在 http://localhost")
    exit(1)

# 测试2：获取课程列表
print("\n[测试2] 获取课程列表")
print("-" * 40)
try:
    response = session.post(f"{base_url}/admin/course/list", timeout=5)
    print(f"状态码: {response.status_code}")
    if response.status_code == 200:
        data = response.json()
        print(f"返回数据: {json.dumps(data, ensure_ascii=False, indent=2)[:500]}")
    else:
        print(f"请求失败: {response.text}")
except Exception as e:
    print(f"请求失败: {e}")

# 测试3：获取学生列表
print("\n[测试3] 获取学生列表")
print("-" * 40)
try:
    response = session.post(f"{base_url}/admin/student/list", timeout=5)
    print(f"状态码: {response.status_code}")
    if response.status_code == 200:
        data = response.json()
        print(f"返回数据: {json.dumps(data, ensure_ascii=False, indent=2)[:500]}")
    else:
        print(f"请求失败: {response.text}")
except Exception as e:
    print(f"请求失败: {e}")

print("\n" + "="*60)
print("          测试完成!")
print("="*60)