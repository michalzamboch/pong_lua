if (Get-Command winget) {
    winget install --id Love2d.Love2d
}
else {
    Write-Host "Need to have installed Winget package manager." -ForegroundColor Red
}