@echo off
chcp 65001 > nul
echo ========================================
echo    选课系统 - 数据库初始化脚本
echo ========================================
echo.

REM MySQL配置（请根据实际情况修改）
set MYSQL_HOST=localhost
set MYSQL_PORT=3306
set MYSQL_USER=root
set MYSQL_PASSWORD=123456
set DATABASE_NAME=course_selection

echo [信息] 数据库配置:
echo   主机: %MYSQL_HOST%
echo   端口: %MYSQL_PORT%
echo   用户名: %MYSQL_USER%
echo   数据库: %DATABASE_NAME%
echo.
echo [提示] 如果MySQL配置不同，请修改此脚本中的变量
echo.

REM 检查MySQL是否可用
where mysql >nul 2>nul
if %ERRORLEVEL% neq 0 (
    echo [错误] 未找到mysql命令！
    echo 请确保MySQL已安装并添加到系统PATH
    echo.
    pause
    exit /b 1
)

echo [信息] 正在创建数据库...
mysql -h%MYSQL_HOST% -P%MYSQL_PORT% -u%MYSQL_USER% -p%MYSQL_PASSWORD% -e "CREATE DATABASE IF NOT EXISTS %DATABASE_NAME% DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"

if %ERRORLEVEL% neq 0 (
    echo [错误] 创建数据库失败！
    echo 请检查MySQL连接配置
    echo.
    pause
    exit /b 1
)

echo [成功] 数据库创建完成！
echo [信息] 正在导入数据...

mysql -h%MYSQL_HOST% -P%MYSQL_PORT% -u%MYSQL_USER% -p%MYSQL_PASSWORD% %DATABASE_NAME% < sql\course_selection.sql

if %ERRORLEVEL% neq 0 (
    echo [错误] 导入数据失败！
    echo.
    pause
    exit /b 1
)

echo.
echo ========================================
echo [成功] 数据库初始化完成！
echo ========================================
echo.
echo 现在可以运行 '启动系统.bat' 启动选课系统了！
echo.
pause