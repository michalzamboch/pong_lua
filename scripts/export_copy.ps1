$sourcePath = "love-11.4-win64"
$destinationPath = "Pong"
$loveExecutable = $sourcePath + "\game.exe"

if (Test-Path $destinationPath) {
    Remove-Item $destinationPath -Force -Recurse
}

New-Item -Path "." -Name $destinationPath -ItemType "directory"
Get-ChildItem -Path $sourcePath -Include *.dll -Recurse | Copy-Item -Destination $destinationPath
Get-ChildItem -Path $loveExecutable | Copy-Item -Destination $destinationPath