$logFile = "C:\temp\installlog.txt"
$isanyerror = $false

function LogWrite {
    param ([string]$logString)
 
    Add-Content -Path $logFile -Value $logString 
 }

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
    # try to install chocolatey
    try {
        Write-Host "Chocolatey is not installed"
        Write-Host "Installing Chocolatey"
        #insatll chocolatey
        Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
    }
    catch {
        LogWrite "👎Error installing Chocolatey: $($_.Exception.Message)"
        $isanyerror = $true
    }
}

# Read software list from file
$software = Get-Content chocoinstall.txt

# Install each one
foreach ($app in $software) {
        try {
                choco install $app -y 
            }
            catch {
                LogWrite "👎Error using chocolatey to install $($app): $($_.Exception.Message)"
                $isanyerror = $true
            }
}

#install vscode extensions
if (Get-Command code -ErrorAction SilentlyContinue) {
    $vscodeextensions = Get-Content vscodeextensions.txt
    foreach ($extension in $vscodeextensions) {
        code --install-extension $extension
    }
} else {
    LogWrite "👎VSCode is not installed"
    $isanyerror = $true
}


if ($isanyerror -eq $true) {
    LogWrite "👎There are some errors"
    Write-Host "There are some errors"
} else {
    LogWrite "👍All done"
    Write-Host "All done"
    Write-Host "do not forget to restart your computer"
}



