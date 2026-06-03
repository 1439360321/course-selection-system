@echo off
setlocal

echo ==============================================
echo     Course Selection System - Quick Start
echo ==============================================
echo.

:: Step 1: Set Java Environment
echo [1/3] Setting Java Environment...
set "JAVA_HOME=C:\Program Files\Java\jdk-17"
set "MAVEN_HOME=D:\apache-maven-3.9.16-bin\apache-maven-3.9.16"
set "PATH=%JAVA_HOME%\bin;%MAVEN_HOME%\bin;%PATH%"

java -version
if %errorlevel% neq 0 (
    echo ERROR: Java not found!
    pause
    exit /b 1
)
echo OK: Java 17 is ready
echo.

:: Step 2: Check if jar exists
if not exist "ruoyi-admin\target\ruoyi-admin.jar" (
    echo [2/3] Building Project...
    call mvn clean package -Dmaven.test.skip=true
    if %errorlevel% neq 0 (
        echo ERROR: Build failed!
        pause
        exit /b 1
    )
    echo OK: Build completed
) else (
    echo [2/3] Skipping build - jar file already exists
)
echo.

:: Step 3: Start Application
echo [3/3] Starting Application...
echo ==============================================
echo URL: http://localhost
echo Press Ctrl+C to stop
echo ==============================================
echo.

set JAVA_OPTS=-Xms256m -Xmx1024m -XX:MetaspaceSize=128m -XX:MaxMetaspaceSize=512m
java %JAVA_OPTS% -jar ruoyi-admin\target\ruoyi-admin.jar

pause