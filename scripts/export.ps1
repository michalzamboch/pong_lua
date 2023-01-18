# Source tutorial: https://www.youtube.com/watch?v=h7II1fiaWKA

$zipFile = "game.zip"
$loveFile = "game.love"
$url = "https://github.com/love2d/love/releases/download/11.4/love-11.4-win64.zip"
$exportFolder = "love-11.4-win64"
$tmpZipFile = "love-win64.zip"

$loveExecutable = $exportFolder + "\love.exe"
$exportLoveFile = $exportFolder + "\" + $loveFile

$finalExportFolder = "Pong"

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
    
    if (Test-Path $finalExportFolder) {
        Remove-Item $finalExportFolder -Force -Recurse
    }
}

function MakeLoveFile() {
    Compress-Archive -Path ..\src\* -DestinationPath $zipFile
    Rename-Item -Path $zipFile -NewName $loveFile
}

function MakeTargetDirectory() {
    Invoke-WebRequest -URI $url -OutFile $tmpZipFile
    Expand-Archive -Path $tmpZipFile -DestinationPath "." -Force
    Remove-Item $tmpZipFile
}

function MoveLoveFile() {
    Move-Item -Path $loveFile -Destination $exportFolder
}

function PrepareExportFolder() {
    New-Item -Path "." -Name $finalExportFolder -ItemType "directory"
    Get-ChildItem -Path $exportFolder -Include *.dll -Recurse | Copy-Item -Destination $finalExportFolder
}

function MakeExeFile() {
    $cmdToRun = "copy /b " + $loveExecutable + " + " + $exportLoveFile + " " + $finalExportFolder + "\game.exe"
    Set-Clipboard -Value $cmdToRun
    
    Write-Host
    Write-Host "After opening Command Line run this command:" -ForegroundColor Cyan
    Write-Host $cmdToRun -ForegroundColor Cyan
    Write-Host 
    Write-Host "Command is copied in your clipboard." -ForegroundColor Cyan
    Write-Host "Paste it with right click." -ForegroundColor Cyan
    Write-Host

    cmd.exe
}

# ------------------------------------------------------------------

Cleanup
MakeLoveFile
MakeTargetDirectory
MoveLoveFile
PrepareExportFolder
MakeExeFile