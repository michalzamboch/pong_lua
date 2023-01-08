# Source tutorial: https://www.youtube.com/watch?v=h7II1fiaWKA

$zipFile = ".\game.zip"

Compress-Archive -Path ..\src\* -DestinationPath $zipFile
Rename-Item -Path $zipFile -NewName "game.love"