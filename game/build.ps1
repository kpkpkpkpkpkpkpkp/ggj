Copy-Item .\main.lua .\game\main.lua
Copy-Item .\src\* .\game\src
Copy-Item .\assets\*.png .\game\assets

Compress-Archive .\* ggj.zip
Move-Item -Force .\ggj.zip .\ggj.love
cmd /c copy /b .\love.exe+.\ggj.love ggj.exe
Remove-Item .\ggj.love
