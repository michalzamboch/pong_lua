# Source tutorial: https://www.youtube.com/watch?v=h7II1fiaWKA

$zipFile = "game.zip"
$loveFile = "game.love"
$url = "https://github.com/love2d/love/releases/download/11.4/love-11.4-win64.zip"
$exportFolder = "love-11.4-win64"
$tmpZipFile = "love-win64.zip"
$destination = "."

$loveExecutable = $exportFolder + "\love.exe"
$exportLoveFile = $exportFolder + "\" + $loveFile

# ------------------------------------------------------------------

function Cleanup() {
    if (Test-Path $zipFile) {
        Remove-Item $zipFile
    }

    if (Test-Path $loveFile) {
        Remove-Item $loveFile
    }

    if (Test-Path $exportFolder) {
        Remove-Item $exportFolder -Force -Recurse
    }
}

function MakeLoveFile() {
    Compress-Archive -Path ..\src\* -DestinationPath $zipFile
    Rename-Item -Path $zipFile -NewName $loveFile
}

function MakeTargetDirectory() {
    Invoke-WebRequest -URI $url -OutFile $tmpZipFile
    Expand-Archive -Path $tmpZipFile -DestinationPath $destination -Force
    Remove-Item $tmpZipFile
}

function MoveLoveFile() {
    Move-Item -Path $loveFile -Destination $exportFolder
}

function MakeExeFile() {
    $cmdToRun = "copy /b " + $loveExecutable + " + " + $exportLoveFile + " game.exe"
    Write-Host "After opening Command Line run this command:" -ForegroundColor Cyan
    Write-Host $cmdToRun -ForegroundColor Cyan
    Write-Host
    cmd.exe
}

# ------------------------------------------------------------------

Cleanup
MakeLoveFile
MakeTargetDirectory
MoveLoveFile
MakeExeFile