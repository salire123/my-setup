#check is running as admin
$admin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")
if ($admin -eq $false) {
    Write-Host "Please run as administrator"
    exit
}

#check if chocolatey is installed
if (Get-Command choco -ErrorAction SilentlyContinue) {
    Write-Host "Chocolatey is installed"
} else {
    Write-Host "Chocolatey is not installed"
    Write-Host "Installing Chocolatey"
    #insatll chocolatey
    Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
}


# Read software list from file
$software = Get-Content chocoinstall.txt

# Install each one
foreach ($app in $software) {
    choco install $app -y
}

#install vscode extensions
if (Get-Command code -ErrorAction SilentlyContinue) {
    $vscodeextensions = Get-Content vscodeextensions.txt
    foreach ($extension in $vscodeextensions) {
        code --install-extension $extension
    }
}

