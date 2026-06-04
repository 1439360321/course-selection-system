import requests
import json

base_url = "http://localhost"

print("测试教师查看学生成绩功能（安全验证）")
print("="*60)

# 1. 教师登录
print("\n[步骤1] 教师 T2021001 登录")
session = requests.Session()
login_data = {
    "username": "T2021001",
    "password": "123456",
    "rememberMe": "false"
}
response = session.post(f"{base_url}/login", data=login_data)
print(f"状态码: {response.status_code}")
data = response.json()
print(f"响应: {data.get('msg', '')}")

# 2. 获取教师课程列表
print("\n[步骤2] 获取教师课程列表")
response = session.post(f"{base_url}/teacher/course/list", data={"tno": "T2021001"})
data = response.json()
print(f"课程数量: {data.get('total', 0)}")
courses = data.get('rows', [])
for course in courses:
    print(f"  {course.get('cno')} - {course.get('cname')}")

# 3. 测试查看自己教授课程的学生成绩（应该成功）
print("\n[步骤3] 查看自己教授的课程 C001 的学生成绩")
response = session.post(f"{base_url}/teacher/course/students/list", data={"cno": "C001"})
data = response.json()
print(f"状态码: {response.status_code}")
print(f"学生数量: {data.get('total', 0)}")
if data.get('rows'):
    for student in data['rows']:
        print(f"  {student.get('sno')} - {student.get('sname')} - 总分:{student.get('totalScore')}")

# 4. 测试查看其他教师的课程成绩（应该返回空数据）
print("\n[步骤4] 尝试查看其他教师的课程 C002 的学生成绩（安全测试）")
response = session.post(f"{base_url}/teacher/course/students/list", data={"cno": "C002"})
data = response.json()
print(f"状态码: {response.status_code}")
print(f"学生数量: {data.get('total', 0)}")
if data.get('total') == 0:
    print("  安全验证通过 - 返回空数据")
else:
    print("  安全验证失败 - 返回了数据")

# 5. 测试查看不存在的课程（应该返回空数据）
print("\n[步骤5] 尝试查看不存在的课程 C999 的学生成绩")
response = session.post(f"{base_url}/teacher/course/students/list", data={"cno": "C999"})
data = response.json()
print(f"状态码: {response.status_code}")
print(f"学生数量: {data.get('total', 0)}")

print("\n" + "="*60)
print("测试完成！")