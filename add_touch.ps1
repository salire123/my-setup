# This PowerShell script copies a specified .ps1 file to the System32 directory

# Define the path to your script
$scriptPath = "D:\disk2main\mycode\my-setup\touch.cmd"

# Define the destination path in System32
$destination = "C:\Windows\System32\touch.cmd"

# Check if the script exists
if (Test-Path $scriptPath) {
    # Copy the script to System32
    try {
        Copy-Item -Path $scriptPath -Destination $destination -Force
        Write-Host "Script copied successfully to $destination"
    } catch {
        Write-Error "An error occurred: $_"
    }
} else {
    Write-Error "The script at $scriptPath does not exist."
}
