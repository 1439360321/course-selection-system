import subprocess

# Read the fixed UTF-8 file
with open(r'd:\course-selection-system\temp_project\course_selection_utf8.sql', 'r', encoding='utf-8') as f:
    content = f.read()

# Import using subprocess - use text mode
result = subprocess.run([
    r'C:\Program Files\MySQL\MySQL Server 8.0\bin\mysql.exe',
    '-h', 'localhost',
    '-u', 'root',
    '-p123456',
    '--default-character-set=utf8mb4',
    'course_selection'
], input=content, capture_output=True, text=True, encoding='utf-8')

print("STDOUT:", result.stdout)
print("STDERR:", result.stderr)
print("Return code:", result.returncode)