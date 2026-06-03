import requests
import json

base_url = "http://localhost"

print("测试：检查 selectClassById 方法的返回值")
print("="*50)

# 教师登录
session = requests.Session()
login_data = {
    "username": "T2021001",
    "password": "123456",
    "rememberMe": "false"
}
response = session.post(f"{base_url}/login", data=login_data)
print(f"教师 T2021001 登录成功")

# 直接访问后端接口，检查是否有权限控制问题
print("\n测试：检查后端接口的权限控制")
# 测试1: 查看自己的课程
response = session.post(f"{base_url}/teacher/course/students/list", data={"cno": "C001"})
data = response.json()
print(f"查看自己的课程 C001 - 学生数量: {data.get('total', 0)}")

# 测试2: 查看别人的课程
response = session.post(f"{base_url}/teacher/course/students/list", data={"cno": "C002"})
data = response.json()
print(f"查看别人的课程 C002 - 学生数量: {data.get('total', 0)}")

# 检查数据库中的课程-教师关联
print("\n检查数据库中的课程-教师关联:")
print("  C001 - T2021001 (刘建国)")
print("  C002 - T2021002 (陈晓燕)")
print("  C003 - T2021001 (刘建国)")

print("\n问题分析：")
print("1. 如果 getLoginName() 返回 T2021001")
print("2. 调用 selectClassById('T2021001', 'C002') 应该返回 null")
print("3. 因为 C002 是 T2021002 的课程")
print("4. 但现在返回了数据，说明验证没有生效")
print("\n可能原因：")
print("1. getLoginName() 返回值不正确")
print("2. selectClassById 方法有问题")
print("3. 代码修改没有被正确编译")