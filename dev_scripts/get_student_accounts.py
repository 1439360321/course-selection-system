import pymysql

# 连接数据库
conn = pymysql.connect(
    host='localhost',
    user='root',
    password='123456',
    database='course_selection',
    charset='utf8mb4'
)

cursor = conn.cursor()

# 查询学生表
print("=== 学生信息 ===")
cursor.execute("SELECT sno, sname, password FROM student")
students = cursor.fetchall()
print(f"共有 {len(students)} 名学生:")
for student in students:
    print(f"  学号: {student[0]}, 姓名: {student[1]}, 密码: {student[2]}")

# 查询用户表中的学生账号
print("\n=== 系统用户表中的学生 ===")
cursor.execute("""
    SELECT u.user_id, u.login_name, u.user_name, u.password 
    FROM sys_user u 
    WHERE u.user_type = 'S'
""")
sys_users = cursor.fetchall()
print(f"共有 {len(sys_users)} 个学生账号:")
for user in sys_users:
    print(f"  用户ID: {user[0]}, 登录名: {user[1]}, 姓名: {user[2]}, 密码: {user[3]}")

conn.close()