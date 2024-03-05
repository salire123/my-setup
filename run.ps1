# Define the path for the log file
$LogFilePath = ".\log\install.log"
$isAnyError = $false 

# Write a function to write to the log file
function Write-Log {
    Param ([string]$Message)
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    "$timestamp - $Message" | Out-File -FilePath $LogFilePath -Append
}

# Test if the script is running as administrator
function Test-Admin {
    $isAdmin = ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
    if (-not $isAdmin) {
        Write-Log "Please run as administrator"
        Write-Host "Please run as administrator"
        exit
    }
}

# Install Chocolatey
function Install-Chocolatey {
    if (Get-Command choco -ErrorAction SilentlyContinue) {
        Write-Host "Chocolatey is installed"
    }
    else {
        try {
            Write-Host "Installing Chocolatey..."
            Set-ExecutionPolicy Bypass -Scope Process -Force
            [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
            Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
            Write-Log "Chocolatey installation completed successfully."
            Write-Host "Chocolatey installation completed successfully."
        }
        catch {
            Write-Log "Error installing Chocolatey: $($_.Exception.Message)"
            $isAnyError = $true 
        }
    }
}

function Update-EnvironmentPath {
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")
}

function Install-VSCodeExtensions {
    param ([string]$vscodeExtensionsListPath)
    Write-Host "Installing Visual Studio Code extensions from list..."
    if (Test-Path $vscodeExtensionsListPath) {
        $vscodeExtensions = Get-Content $vscodeExtensionsListPath
        foreach ($extension in $vscodeExtensions) {
            try {
                Write-Host "Installing $extension..."
                code --install-extension $extension --force
                Write-Log "Installed VSCode extension: $extension"
            }
            catch {
                Write-Log "Error installing VSCode extension $extension\: $($_.Exception.Message)"
                $isAnyError = $true
            }
        }
    }
    else {
        Write-Host "The Visual Studio Code extensions list file does not exist: $vscodeExtensionsListPath"
        Write-Log "The Visual Studio Code extensions list file does not exist: $vscodeExtensionsListPath"
    }
}


function Upload-VSCodeSettings {
    param ([string]$settingPath)
    $vscodeSettingsPath = "$env:APPDATA\Code\User\settings.json"
    try {
        Write-Host "Uploading settings.json to VSCode settings directory..."
        Copy-Item $settingPath -Destination $vscodeSettingsPath -Force
        Write-Log "Uploaded settings.json successfully."
    }
    catch {
        Write-Log "Error uploading settings.json: $($_.Exception.Message)"
        $isAnyError = $true
    }
}


try{
    Test-Admin
    Install-Chocolatey
    choco install .\config-save\chocoinstall-packages.config.config --yes --no-progress
    Update-EnvironmentPath
    Write-Log "Chocolatey installation completed successfully."
    Install-VSCodeExtensions -vscodeExtensionsListPath ".\config-save\vscode-extensions-list.txt"
    Upload-VSCodeSettings -settingPath ".\config-save\settings.json"
}
catch {
    Write-Log "Error installing Chocolatey: $($_.Exception.Message)"
    $isAnyError = $true 
}
