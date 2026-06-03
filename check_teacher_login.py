import requests
import json

base_url = "http://localhost"

print("检查并修复教师登录问题")
print("="*50)

# 先登录管理员账号
print("\n[步骤1] 管理员登录")
admin_session = requests.Session()
login_data = {
    "username": "admin",
    "password": "admin123",
    "rememberMe": "false"
}
response = admin_session.post(f"{base_url}/login", data=login_data)
print(f"状态码: {response.status_code}")
try:
    data = response.json()
    print(f"响应: {data.get('msg', '')}")
except:
    print(f"登录失败")
    
# 获取系统用户列表，检查教师账号是否存在
print("\n[步骤2] 检查系统用户表中的教师账号")
response = admin_session.post(f"{base_url}/system/user/list", data={"pageNum": 1, "pageSize": 100})
try:
    data = response.json()
    users = data.get('rows', [])
    print(f"系统用户数量: {len(users)}")
    print("系统用户列表:")
    for user in users:
        print(f"  {user.get('loginName')} - {user.get('userName')}")
except Exception as e:
    print(f"获取用户列表失败: {e}")

# 获取教师列表
print("\n[步骤3] 获取教师列表")
response = admin_session.get(f"{base_url}/admin/teacher")
print(f"状态码: {response.status_code}")

# 尝试获取教师数据列表
response = admin_session.post(f"{base_url}/admin/teacher/list", data={"pageNum": 1, "pageSize": 100})
try:
    data = response.json()
    teachers = data.get('rows', [])
    print(f"教师数量: {len(teachers)}")
    print("教师列表:")
    for teacher in teachers:
        print(f"  {teacher.get('tno')} - {teacher.get('tname')}")
except Exception as e:
    print(f"获取教师列表失败: {e}")

print("\n结论：教师账号需要在 sys_user 表中创建才能登录系统！")
print("需要为每个教师创建系统用户并分配教师角色。")