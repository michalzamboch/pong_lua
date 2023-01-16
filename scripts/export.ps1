# Source tutorial: https://www.youtube.com/watch?v=h7II1fiaWKA

$zipFile = "game.zip"
$loveFile = "game.love"

# ------------------------------------------------------------------

if (Test-Path $zipFile) {
    Remove-Item $zipFile
}

if (Test-Path $loveFile) {
    Remove-Item $loveFile
}

Compress-Archive -Path ..\src\* -DestinationPath $zipFile
Rename-Item -Path $zipFile -NewName $loveFile