import requests
import json

base_url = "http://localhost"

print("检查数据库中的课程-教师关联数据")
print("="*50)

# 管理员登录
session = requests.Session()
login_data = {
    "username": "admin",
    "password": "admin123",
    "rememberMe": "false"
}
response = session.post(f"{base_url}/login", data=login_data)
print(f"管理员登录成功")

# 查询所有课程分配信息
print("\n查询所有课程分配:")
response = session.post(f"{base_url}/admin/class/list", data={"pageNum": 1, "pageSize": 100})
try:
    data = response.json()
    classes = data.get('rows', [])
    print(f"课程分配数量: {len(classes)}")
    print("课程分配列表:")
    for cls in classes:
        print(f"  {cls.get('cno')} - {cls.get('cname')} - {cls.get('tno')}")
except Exception as e:
    print(f"查询失败: {e}")
    print(f"响应内容: {response.text[:500]}")

# 查询所有教师
print("\n查询所有教师:")
response = session.post(f"{base_url}/admin/teacher/list", data={"pageNum": 1, "pageSize": 100})
try:
    data = response.json()
    teachers = data.get('rows', [])
    print(f"教师数量: {len(teachers)}")
    print("教师列表:")
    for teacher in teachers:
        print(f"  {teacher.get('tno')} - {teacher.get('tname')}")
except Exception as e:
    print(f"查询失败: {e}")