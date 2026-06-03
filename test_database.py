import subprocess

def run_sql(sql):
    """执行SQL查询并返回结果"""
    result = subprocess.run([
        r'C:\Program Files\MySQL\MySQL Server 8.0\bin\mysql.exe',
        '-h', 'localhost',
        '-u', 'root',
        '-p123456',
        '-e', sql,
        'course_selection'
    ], capture_output=True, text=True, encoding='utf-8')
    return result.stdout, result.stderr

print("="*60)
print("      选课系统数据库功能测试")
print("="*60)

# 1. 测试课程表结构
print("\n[测试1] 课程表结构验证")
print("-" * 40)
stdout, stderr = run_sql("DESCRIBE course")
print(stdout)
if stderr:
    print(f"错误: {stderr}")

# 2. 测试课程数据
print("\n[测试2] 课程数据查询")
print("-" * 40)
stdout, stderr = run_sql("SELECT cno, cname, credit, max_students FROM course LIMIT 5")
print(stdout)
if stderr:
    print(f"错误: {stderr}")

# 3. 测试选课记录
print("\n[测试3] 选课记录查询")
print("-" * 40)
stdout, stderr = run_sql("SELECT * FROM courseselection LIMIT 5")
print(stdout)
if stderr:
    print(f"错误: {stderr}")

# 4. 测试学生数据
print("\n[测试4] 学生数据查询")
print("-" * 40)
stdout, stderr = run_sql("SELECT sno, sname, sex FROM student LIMIT 5")
print(stdout)
if stderr:
    print(f"错误: {stderr}")

# 5. 测试教师数据
print("\n[测试5] 教师数据查询")
print("-" * 40)
stdout, stderr = run_sql("SELECT tno, tname, rank FROM teacher LIMIT 5")
print(stdout)
if stderr:
    print(f"错误: {stderr}")

# 6. 测试部门数据
print("\n[测试6] 部门数据查询")
print("-" * 40)
stdout, stderr = run_sql("SELECT dept_id, dept_name FROM department")
print(stdout)
if stderr:
    print(f"错误: {stderr}")

# 7. 测试若依系统表
print("\n[测试7] 系统菜单数据")
print("-" * 40)
stdout, stderr = run_sql("SELECT menu_id, menu_name, path FROM sys_menu WHERE parent_id = 0")
print(stdout)
if stderr:
    print(f"错误: {stderr}")

# 8. 测试选课人数统计
print("\n[测试8] 选课人数统计")
print("-" * 40)
stdout, stderr = run_sql("""
    SELECT c.cno, c.cname, COUNT(cs.sno) as enrolled, c.max_students
    FROM course c 
    LEFT JOIN courseselection cs ON c.cno = cs.cno 
    GROUP BY c.cno, c.cname, c.max_students
    LIMIT 5
""")
print(stdout)
if stderr:
    print(f"错误: {stderr}")

print("\n" + "="*60)
print("          测试完成!")
print("="*60)