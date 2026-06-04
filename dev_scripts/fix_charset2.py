import subprocess

# Read the file as bytes first
with open(r'd:\course-selection-system\temp_project\course_selection.sql', 'rb') as f:
    content_bytes = f.read()

# Try multiple encodings
encodings = ['utf-8', 'gbk', 'gb2312', 'gb18030', 'cp1252']
content = None

for enc in encodings:
    try:
        content = content_bytes.decode(enc)
        print(f"Successfully decoded with {enc}")
        break
    except:
        continue

if content is None:
    # Fallback: replace problematic characters
    content = content_bytes.decode('utf-8', errors='replace')
    print("Used fallback decoding")

# Fix the check constraint
content = content.replace("_gbk'??',_gbk'?'", "_utf8mb4'男',_utf8mb4'女'")
content = content.replace("CHECK ((`sex` in (_gbk'??',_gbk'?')))", "CHECK ((`sex` in ('男','女')))")

# Write fixed file
with open(r'd:\course-selection-system\temp_project\course_selection_utf8.sql', 'w', encoding='utf-8') as f:
    f.write(content)

print("Fixed SQL file created!")

# Import using subprocess with UTF-8 encoding
subprocess.run([
    r'C:\Program Files\MySQL\MySQL Server 8.0\bin\mysql.exe',
    '-h', 'localhost',
    '-u', 'root',
    '-p123456',
    '--default-character-set=utf8mb4',
    'course_selection'
], input=content.encode('utf-8'))

print("Import completed!")