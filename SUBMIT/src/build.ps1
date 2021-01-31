Copy-Item -Force ".\main.lua" -Destination "..\release\main.lua"
Copy-Item -Force ".\src\*" -Destination "..\release\src" -Recurse
Copy-Item -Force ".\assets\*" -Destination "..\release\assets" -Recurse
Copy-Item -Force ".\lib\*" -Destination "..\release\lib" -Recurse


$compress = @{
  Path = "..\release\main.lua","..\release\src","..\release\assets","..\release\lib"
  CompressionLevel = "Fastest"
  DestinationPath = ".\ggj.zip"
}
Compress-Archive -Force @compress

Move-Item -Force .\ggj.zip ..\release\ggj.love
cmd /c copy /b ..\release\love.exe+..\release\ggj.love ..\release\ggj.exe
Remove-Item ..\release\ggj.love
