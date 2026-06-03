@echo off
cd /d d:\course-selection-system\temp_project\RuoYi
echo JAVA_HOME=%JAVA_HOME%
echo MAVEN_HOME=%MAVEN_HOME%
echo.
echo Building project...
call D:\apache-maven-3.9.16-bin\apache-maven-3.9.16\bin\mvn.cmd clean package -Dmaven.test.skip=true -X
echo.
echo Build finished.
pause