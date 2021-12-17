
Remove-Item -Path '.\game' -Recurse -Force
New-Item -Path '.' -Name 'game' -ItemType 'directory'
New-Item -Path '.\game' -Name 'src' -ItemType 'directory'
New-Item -Path '.\game' -Name 'lib' -ItemType 'directory'
New-Item -Path '.\game\lib' -Name 'HC' -ItemType 'directory'
New-Item -Path '.\game\assets' -Name 'Backgrounds' -ItemType 'directory'
New-Item -Path '.\game\assets' -Name 'fonts' -ItemType 'directory'
New-Item -Path '.\game\assets' -Name 'sounds' -ItemType 'directory'
New-Item -Path '.\game\assets\sounds' -Name 'old' -ItemType 'directory'
New-Item -Path '.\game\assets' -Name 'sprites' -ItemType 'directory'
New-Item -Path '.\game\assets\sprites' -Name 'Updated Assets' -ItemType 'directory'
New-Item -Path '.\game\assets\sprites\Updated Assets' -Name 'Backgrounds' -ItemType 'directory'

Copy-Item -Force ".\main.lua" -Destination ".\game\main.lua"
Copy-Item -Force ".\src\*" -Destination ".\game\src" -Recurse
Copy-Item -Force ".\assets\*" -Destination ".\game\assets" -Recurse
Copy-Item -Force ".\lib\*" -Destination ".\game\lib" -Recurse
Copy-Item -Force ".\love\*" -Destination ".\game"

$compress = @{
  Path = ".\game\main.lua",".\game\src",".\game\assets",".\game\lib"
  CompressionLevel = "Fastest"
  DestinationPath = ".\ggj.zip"
}
Compress-Archive -Force @compress

Move-Item -Force .\ggj.zip .\game\ggj.love
cmd /c copy /b .\game\love.exe+.\game\ggj.love .\game\ggj.exe
Remove-Item .\game\ggj.love
