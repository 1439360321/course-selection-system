import subprocess

# Read the GBK-encoded SQL file
with open(r'd:\course-selection-system\temp_project\course_selection.sql', 'r', encoding='gbk') as f:
    content = f.read()

# Fix the check constraint - replace the garbled characters with proper ones
content = content.replace("_gbk'��',_gbk'Ů'", "_utf8mb4'男',_utf8mb4'女'")

# Write back with UTF-8 encoding
with open(r'd:\course-selection-system\temp_project\course_selection_utf8.sql', 'w', encoding='utf-8') as f:
    f.write(content)

print("Fixed SQL file created!")

# Import the fixed file
subprocess.run([
    r'C:\Program Files\MySQL\MySQL Server 8.0\bin\mysql.exe',
    '-h', 'localhost',
    '-u', 'root',
    '-p123456',
    'course_selection'
], input=content.encode('utf-8'))

print("Import completed!")