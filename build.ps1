
$compress = @{
  Path = ".\main.lua", ".\src", ".\assets", ".\assets\testing", ".\assets\sounds"
  CompressionLevel = "Fastest"
  DestinationPath = ".\ggj.zip"
}
Compress-Archive -Force @compress

Move-Item -Force .\ggj.zip .\game\ggj.love
cmd /c copy /b .\love.exe+.\ggj.love ggj.exe
# Remove-Item .\ggj.love
