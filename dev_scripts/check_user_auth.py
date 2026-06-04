import sqlite3
import requests

# 创建内存数据库来测试查询逻辑
conn = sqlite3.connect(':memory:')
cursor = conn.cursor()

# 创建模拟表
cursor.execute('''CREATE TABLE sys_user (user_id INTEGER PRIMARY KEY, login_name TEXT, password TEXT, status TEXT)''')
cursor.execute('''CREATE TABLE teacher (tno TEXT PRIMARY KEY, tname TEXT, password TEXT)''')

# 插入测试数据
cursor.execute("INSERT INTO sys_user VALUES (1, 'admin', 'admin123', '0')")
cursor.execute("INSERT INTO teacher VALUES ('T001', '张老师', '123456')")

conn.commit()

# 查询教师在系统用户表中是否存在
cursor.execute("SELECT * FROM sys_user WHERE login_name = 'T001'")
user = cursor.fetchone()
print(f"教师T001在sys_user表中: {'存在' if user else '不存在'}")

# 查询教师表
cursor.execute("SELECT * FROM teacher WHERE tno = 'T001'")
teacher = cursor.fetchone()
print(f"教师T001在teacher表中: {'存在' if teacher else '不存在'}")

conn.close()

print("\n结论：教师账号需要在sys_user表中创建才能登录！")