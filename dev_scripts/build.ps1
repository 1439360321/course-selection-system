$ErrorActionPreference = "Continue"
$env:JAVA_HOME = "C:\Program Files\Java\jdk-17"
$env:PATH = "$env:JAVA_HOME\bin;$env:PATH"

Write-Host "Starting Maven build..."
Write-Host "JAVA_HOME: $env:JAVA_HOME"

cd d:\course-selection-system\temp_project\RuoYi
& "D:\apache-maven-3.9.16-bin\apache-maven-3.9.16\bin\mvn.cmd" clean package -DskipTests 2>&1 | ForEach-Object { Write-Host $_ }

Write-Host "Build finished. Checking for jar..."
Get-ChildItem -Path "d:\course-selection-system\temp_project\RuoYi\ruoyi-admin\target" -Filter "*.jar" -Recurse | Select-Object FullName