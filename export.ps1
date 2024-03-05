
# export choco packages
choco export ".\config-save\chocoinstall-packages.config" --force --verbose

# export vscode extensions
code --list-extensions > .\config-save\vscode-extensions-list.txt

# export vscode settings
try{
    Copy-Item $env:APPDATA\Code\User\settings.json .\config-save\settings.json
}
catch{
    Write-Host "no settings.json"
}

try{
    Copy-Item $env:APPDATA\Code\User\keybindings.json .\config-save\keybindings.json
}
catch{
    Write-Host "no keybindings.json"
}