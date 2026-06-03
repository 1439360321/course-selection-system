@echo off
cd /d "d:\course-selection-system\temp_project"
"C:\Program Files\MySQL\MySQL Server 8.0\bin\mysql.exe" -h localhost -u root -p123456 course_selection < "d:\course-selection-system\temp_project\course_selection.sql"
echo Import completed!
pause