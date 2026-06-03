import requests
import json

base_url = "http://localhost"

print("测试教师查看学生成绩功能")
print("="*50)

# 1. 先登录教师账号
print("\n[步骤1] 教师登录")
login_data = {
    "username": "T001",
    "password": "123456",
    "rememberMe": "false"
}

session = requests.Session()
response = session.post(f"{base_url}/login", data=login_data)
print(f"状态码: {response.status_code}")
try:
    data = response.json()
    print(f"响应: {json.dumps(data, ensure_ascii=False)}")
except:
    print(f"响应内容: {response.text[:500]}")

# 2. 获取教师教授的课程列表
print("\n[步骤2] 获取教师课程列表")
response = session.post(f"{base_url}/teacher/course/list", data={"tno": "T001"})
print(f"状态码: {response.status_code}")
try:
    data = response.json()
    print(f"课程数量: {data.get('total', 0)}")
    if data.get('rows'):
        print("课程列表:")
        for course in data['rows'][:3]:
            print(f"  {course.get('cno')} - {course.get('cname')}")
except Exception as e:
    print(f"解析失败: {e}")
    print(f"响应内容: {response.text[:500]}")

# 3. 获取学生成绩列表（需要一个有效的cno）
print("\n[步骤3] 获取学生成绩列表")
response = session.post(f"{base_url}/teacher/course/students/list", data={"cno": "C001"})
print(f"状态码: {response.status_code}")
try:
    data = response.json()
    print(f"学生数量: {data.get('total', 0)}")
    if data.get('rows'):
        print("学生列表:")
        for student in data['rows'][:5]:
            print(f"  {student.get('sno')} - {student.get('sname')} - 平时:{student.get('normalScore')} - 考试:{student.get('testScore')}")
except Exception as e:
    print(f"解析失败: {e}")
    print(f"响应内容: {response.text[:500]}")

print("\n测试完成!")