if (-Not (Get-Command lua)) {
    
    if (-Not (Get-Command scoop)) {
        Write-Host "Installing Scoop package manager." -ForegroundColor Cyan
        Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
        irm get.scoop.sh | iex
    }

    Write-Host "Installing Lua interpreter." -ForegroundColor Cyan
    scoop update --all
    scoop install lua
}

if (Get-Command winget) {
    winget install --id Love2d.Love2d
}
else {
    Write-Host "Need to have installed Winget package manager." -ForegroundColor Red
}