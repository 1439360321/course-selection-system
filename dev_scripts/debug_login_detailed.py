import requests
import json

base_url = "http://localhost"

print("="*60)
print("      选课系统登录调试")
print("="*60)

session = requests.Session()

# 首先获取登录页面
print("\n[步骤1] 获取登录页面")
print("-" * 40)
try:
    response = session.get(f"{base_url}/login", timeout=5)
    print(f"状态码: {response.status_code}")
    print(f"Content-Type: {response.headers.get('Content-Type')}")
except Exception as e:
    print(f"获取登录页面失败: {e}")
    exit(1)

# 尝试登录
print("\n[步骤2] 尝试登录")
print("-" * 40)
login_data = {
    "username": "admin",
    "password": "admin123",
    "rememberMe": False
}

try:
    response = session.post(f"{base_url}/login", data=login_data, timeout=5)
    print(f"状态码: {response.status_code}")
    print(f"响应头: {dict(response.headers)}")

    # 尝试解析JSON
    try:
        data = response.json()
        print(f"响应JSON: {json.dumps(data, ensure_ascii=False, indent=2)}")
    except:
        print(f"响应内容(前1000字符): {response.content.decode('utf-8')[:1000]}")

    print(f"\n当前Session ID: {session.cookies.get('JSESSIONID')}")
except Exception as e:
    print(f"登录请求失败: {e}")

# 检查session中的内容
print("\n[步骤3] 检查已登录用户的session")
print("-" * 40)
try:
    # 尝试访问首页
    response = session.get(f"{base_url}/index", timeout=5, allow_redirects=False)
    print(f"状态码: {response.status_code}")
    print(f"重定向: {response.headers.get('Location', '无')}")
except Exception as e:
    print(f"获取首页失败: {e}")

print("\n" + "="*60)