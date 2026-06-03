import pymysql

conn = pymysql.connect(host='localhost', user='root', password='root123', database='course_selection', charset='utf8')
cursor = conn.cursor()

# 检查教师数据
cursor.execute('SELECT COUNT(*) FROM teacher')
print(f'教师数量: {cursor.fetchone()[0]}')

# 检查课程数据
cursor.execute('SELECT COUNT(*) FROM class')
print(f'班级/课程数量: {cursor.fetchone()[0]}')

# 检查选课数据
cursor.execute('SELECT COUNT(*) FROM course_selection')
print(f'选课记录数量: {cursor.fetchone()[0]}')

# 检查教师和课程关联
cursor.execute('SELECT t.tno, t.tname, c.cno, c.cname FROM teacher t LEFT JOIN class c ON t.tno = c.tno LIMIT 10')
print('\n教师-课程关联:')
for row in cursor.fetchall():
    print(f'  {row[0]} {row[1]} - {row[2]} {row[3]}')

conn.close()