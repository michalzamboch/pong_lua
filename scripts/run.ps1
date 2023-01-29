$lovePath = "C:\Program Files\LOVE"
$loveExe = ".\love.exe"

# -----------------------------------------

if (-Not (Test-Path -Path $lovePath)) {
    Write-Host "`nCan not find Love2D binary folder.`n" -ForegroundColor Red
    exit
}

pushd
cd ..\src
$sourceDir = pwd

cd $lovePath
.\love.exe $sourceDir

popd