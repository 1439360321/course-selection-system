import requests

base_url = "http://localhost"

print("="*60)
print("      API调试 - 查看实际返回内容")
print("="*60)

# 测试1：登录
print("\n[测试1] 用户登录")
print("-" * 40)
login_data = {
    "username": "admin",
    "password": "admin123"
}

session = requests.Session()
response = session.post(f"{base_url}/login", data=login_data)
print(f"状态码: {response.status_code}")
print(f"响应头: {dict(response.headers)}")
print(f"响应内容长度: {len(response.content)}")

# 测试2：获取课程列表
print("\n[测试2] 获取课程列表")
print("-" * 40)
response = session.post(f"{base_url}/admin/course/list")
print(f"状态码: {response.status_code}")
print(f"响应头: {dict(response.headers)}")
print(f"响应内容长度: {len(response.content)}")
print(f"响应内容(原始): {repr(response.content[:500])}")

# 如果响应不为空，尝试解析
if response.content:
    try:
        print(f"响应内容(解码): {response.content.decode('utf-8')[:500]}")
    except Exception as e:
        print(f"解码失败: {e}")

print("\n" + "="*60)
print("          调试完成!")
print("="*60)