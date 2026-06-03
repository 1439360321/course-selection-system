import sqlite3

# 创建模拟查询来分析问题
conn = sqlite3.connect(':memory:')
cursor = conn.cursor()

# 创建模拟表
cursor.execute('''CREATE TABLE sys_user_role (user_id INTEGER, role_id INTEGER)''')
cursor.execute('''CREATE TABLE sys_role (role_id INTEGER PRIMARY KEY, role_key TEXT)''')

# 插入测试数据（模拟真实情况）
cursor.execute("INSERT INTO sys_role VALUES (100, 'teacher')")
cursor.execute("INSERT INTO sys_role VALUES (101, 'student')")
cursor.execute("INSERT INTO sys_user_role VALUES (23, 100)")  # 教师用户关联教师角色

conn.commit()

# 查询教师角色关联
cursor.execute("SELECT ur.user_id, r.role_key FROM sys_user_role ur JOIN sys_role r ON ur.role_id = r.role_id WHERE r.role_key = 'teacher'")
result = cursor.fetchall()
print("教师角色关联:")
for row in result:
    print(f"  用户ID: {row[0]}, 角色: {row[1]}")

conn.close()

print("\n分析：")
print("1. 教师用户需要在 sys_user 表中存在")
print("2. 教师用户需要在 sys_user_role 表中关联教师角色(role_id=100)")
print("3. Shiro通过 @RequiresRoles(\"teacher\") 验证角色")
print("4. 如果角色验证失败，用户会被重定向或返回权限不足")

print("\n可能的问题：")
print("1. 用户角色关联不正确")
print("2. Shiro配置问题")
print("3. 前端页面加载问题")