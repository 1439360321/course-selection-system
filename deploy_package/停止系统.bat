@echo off
chcp 65001 > nul
echo ========================================
echo    选课系统 - 停止脚本
echo ========================================
echo.

echo [信息] 正在查找Java进程...
tasklist /FI "IMAGENAME eq java.exe" 2>NUL | find /I /N "java.exe" >NUL
if "%ERRORLEVEL%"=="0" (
    echo [信息] 找到Java进程，正在停止...
    taskkill /F /IM java.exe
    echo [成功] 已停止选课系统！
) else (
    echo [提示] 未找到运行中的Java进程
)

echo.
pause