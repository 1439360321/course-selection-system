@echo off
set JAVA_HOME=C:\Program Files\Java\jdk-17
set PATH=%JAVA_HOME%\bin;%PATH%
echo JAVA_HOME=%JAVA_HOME%
echo.
cd /d d:\course-selection-system\temp_project\RuoYi
echo Building project...
call D:\apache-maven-3.9.16-bin\apache-maven-3.9.16\bin\mvn.cmd clean package -Dmaven.test.skip=true
echo.
echo Build finished.
pause