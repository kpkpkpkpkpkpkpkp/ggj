Copy-Item -Force ".\main.lua" -Destination ".\game\main.lua"
Copy-Item -Force ".\src\*" -Destination ".\game\src" -Recurse
Copy-Item -Force ".\assets\*" -Destination ".\game\assets" -Recurse
Copy-Item -Force ".\lib\*" -Destination ".\game\lib" -Recurse


$compress = @{
  Path = ".\game\main.lua",".\game\src",".\game\assets",".\game\lib"
  CompressionLevel = "Fastest"
  DestinationPath = ".\ggj.zip"
}
Compress-Archive -Force @compress

Move-Item -Force .\ggj.zip .\game\ggj.love
cmd /c copy /b .\game\love.exe+.\game\ggj.love .\game\ggj.exe
Remove-Item .\game\ggj.love
