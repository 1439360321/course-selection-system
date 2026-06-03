@echo off
chcp 65001 > nul
echo ========================================
echo    选课系统 - 启动脚本
echo ========================================
echo.

REM 设置Java路径（如果系统已配置JAVA_HOME，可注释掉下面这行）
set JAVA_HOME=C:\Program Files\Java\jdk-17

REM 检查Java是否可用
if not exist "%JAVA_HOME%\bin\java.exe" (
    echo [错误] 未找到Java环境！
    echo 请确保已安装JDK 17或以上版本
    echo 并在脚本中正确配置JAVA_HOME路径
    echo.
    pause
    exit /b 1
)

echo [信息] 使用Java: %JAVA_HOME%\bin\java.exe
echo.

REM 检查jar文件是否存在
if not exist "bin\ruoyi-admin.jar" (
    echo [错误] 未找到bin\ruoyi-admin.jar文件！
    echo 请确保部署包完整
    echo.
    pause
    exit /b 1
)

echo [信息] 正在启动选课系统...
echo [信息] 请稍候，系统启动需要几秒钟...
echo.
echo [提示] 系统启动后，请访问: http://localhost
echo [提示] 按 Ctrl+C 可以停止服务器
echo.
echo ========================================
echo.

REM 启动应用
"%JAVA_HOME%\bin\java.exe" -jar bin\ruoyi-admin.jar

pause