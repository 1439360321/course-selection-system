import requests

base_url = "http://localhost"

print("="*60)
print("      完整API调试")
print("="*60)

# 创建session
session = requests.Session()

# 测试1：访问首页
print("\n[测试1] 访问首页")
print("-" * 40)
response = session.get(f"{base_url}/")
print(f"状态码: {response.status_code}")
print(f"是否重定向: {response.is_redirect}")
print(f"最终URL: {response.url}")

# 测试2：登录
print("\n[测试2] 用户登录")
print("-" * 40)
login_data = {
    "username": "admin",
    "password": "admin123"
}

response = session.post(f"{base_url}/login", data=login_data)
print(f"状态码: {response.status_code}")
print(f"响应头: {dict(response.headers)}")
print(f"Cookies: {session.cookies.get_dict()}")
print(f"响应内容长度: {len(response.content)}")

# 测试3：登录后访问首页
print("\n[测试3] 登录后访问首页")
print("-" * 40)
response = session.get(f"{base_url}/")
print(f"状态码: {response.status_code}")
print(f"响应内容长度: {len(response.content)}")

# 测试4：获取课程列表（使用POST）
print("\n[测试4] POST方式获取课程列表")
print("-" * 40)
response = session.post(f"{base_url}/admin/course/list")
print(f"状态码: {response.status_code}")
print(f"响应头: {dict(response.headers)}")
print(f"响应内容长度: {len(response.content)}")

if response.content:
    try:
        content = response.content.decode('utf-8')
        print(f"响应内容(前500字符): {content[:500]}")
    except Exception as e:
        print(f"解码失败: {e}")
        print(f"响应内容(原始): {repr(response.content[:500])}")

# 测试5：获取课程列表（使用GET）
print("\n[测试5] GET方式获取课程列表")
print("-" * 40)
response = session.get(f"{base_url}/admin/course/list")
print(f"状态码: {response.status_code}")
print(f"响应内容长度: {len(response.content)}")

# 测试6：检查是否需要CSRF token
print("\n[测试6] 检查CSRF token")
print("-" * 40)
response = session.get(f"{base_url}/")
if response.content:
    try:
        content = response.content.decode('utf-8')
        if 'csrfToken' in content or 'csrf-token' in content.lower():
            print("发现CSRF token")
            # 尝试提取token
            import re
            match = re.search(r'csrfToken.*?value="([^"]+)"', content)
            if match:
                print(f"CSRF Token: {match.group(1)}")
    except:
        pass

print("\n" + "="*60)
print("          调试完成!")
print("="*60)