import requests
import json

base_url = "http://localhost"

print("检查教师角色分配")
print("="*50)

# 登录管理员
admin_session = requests.Session()
login_data = {
    "username": "admin",
    "password": "admin123",
    "rememberMe": "false"
}
response = admin_session.post(f"{base_url}/login", data=login_data)

# 获取教师用户的角色信息
print("\n[步骤1] 查询教师用户 T2021001 的角色")
response = admin_session.post(f"{base_url}/system/user/list", data={"pageNum": 1, "pageSize": 100, "userName": "刘建国"})
try:
    data = response.json()
    users = data.get('rows', [])
    if users:
        user = users[0]
        print(f"用户ID: {user.get('userId')}")
        print(f"登录名: {user.get('loginName')}")
        print(f"用户名: {user.get('userName')}")
        print(f"角色ID: {user.get('roleIds')}")
except Exception as e:
    print(f"查询失败: {e}")

# 检查角色表中的教师角色
print("\n[步骤2] 查询教师角色信息")
response = admin_session.post(f"{base_url}/system/role/list", data={"pageNum": 1, "pageSize": 100})
try:
    data = response.json()
    roles = data.get('rows', [])
    for role in roles:
        if '教师' in role.get('roleName', ''):
            print(f"角色ID: {role.get('roleId')}")
            print(f"角色名: {role.get('roleName')}")
            print(f"角色标识: {role.get('roleKey')}")
except Exception as e:
    print(f"查询失败: {e}")

# 检查用户角色关联
print("\n[步骤3] 检查用户角色关联表")
response = admin_session.post(f"{base_url}/system/user/authRole", data={"userId": 23})  # 假设教师用户ID是23
print(f"状态码: {response.status_code}")
try:
    data = response.json()
    print(f"角色列表: {json.dumps(data, ensure_ascii=False)}")
except Exception as e:
    print(f"查询失败: {e}")
    print(f"响应内容: {response.text[:500]}")