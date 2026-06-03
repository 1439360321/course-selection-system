@echo off
cd /d "d:\course-selection-system\temp_project"

echo Dropping existing database...
"C:\Program Files\MySQL\MySQL Server 8.0\bin\mysql.exe" -h localhost -u root -p123456 -e "DROP DATABASE IF EXISTS course_selection"

echo Creating new database with GBK charset...
"C:\Program Files\MySQL\MySQL Server 8.0\bin\mysql.exe" -h localhost -u root -p123456 -e "CREATE DATABASE course_selection CHARACTER SET gbk COLLATE gbk_chinese_ci"

echo Importing SQL file...
"C:\Program Files\MySQL\MySQL Server 8.0\bin\mysql.exe" -h localhost -u root -p123456 course_selection < course_selection.sql

echo Converting database to utf8mb4...
"C:\Program Files\MySQL\MySQL Server 8.0\bin\mysql.exe" -h localhost -u root -p123456 -e "ALTER DATABASE course_selection CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci"

echo Done!
pause