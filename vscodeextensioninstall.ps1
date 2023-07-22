# Error log
$errorlog = "c:\temp\choco-install-errors.txt"

# Check for admin rights
If (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]"Administrator")) {
    Write-Error "Please run as administrator"
    Exit
}

# Install Chocolatey if needed
If (!(Get-Command choco -ErrorAction SilentlyContinue)) {
    Write-Host "Installing Chocolatey..."
    Set-ExecutionPolicy Bypass -Scope Process -Force
    [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
    Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
}

# Load software list 
$software = Get-Content "chocoinstall.txt"

# Install software
foreach ($app in $software) {

    Write-Host "Installing $app"
    
    # Check if already installed
    $installed = choco list -lo $app
    if ($installed) {
        Write-Host "$app is already installed. Skipping."
        Continue
    }

    # Install app
    try {
        choco install $app -y
    }
    catch {
        Write-Error "Error installing $app. $($_.Exception.Message)" | Out-File $errorlog -Append
    }

}

# Install VS Code extensions
$extensions = Get-Content "vscode_extensions.txt"

foreach ($ext in $extensions) {
    Write-Host "Installing $ext VS Code extension"
    try {
        code --install-extension $ext
    }
    catch {
        Write-Error "Error installing $ext. $($_.Exception.Message)" | Out-File $errorlog -Append
    }

}

Write-Host "Done!"