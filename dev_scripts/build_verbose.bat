@echo off
echo Checking environment...
echo JAVA_HOME=%JAVA_HOME%
echo PATH=%PATH%
echo.
cd /d d:\course-selection-system\temp_project\RuoYi
echo Current directory: %CD%
echo.
echo Checking Maven...
dir D:\apache-maven-3.9.16-bin\apache-maven-3.9.16\bin\mvn.cmd
echo.
echo Building project with Maven...
D:\apache-maven-3.9.16-bin\apache-maven-3.9.16\bin\mvn.cmd clean package -Dmaven.test.skip=true
echo.
echo Build finished with exit code: %ERRORLEVEL%
pause