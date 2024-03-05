function ADD-My-ScriptDirectory {
    param ([string]$scriptsDirectory)
    # Define the destination directory in System32
    $destinationDirectory = "C:\Windows\System32"

    # Check if the directory exists
    if (Test-Path $scriptsDirectory) {
        # Get all .cmd files in the directory
        $cmdFiles = Get-ChildItem -Path $scriptsDirectory -Filter "*.cmd"
        foreach ($file in $cmdFiles) {
            $destination = Join-Path -Path $destinationDirectory -ChildPath $file.Name
            try {
                # Copy the .cmd file to System32
                Copy-Item -Path $file.FullName -Destination $destination -Force
                Write-Host "Script $($file.Name) copied successfully to $destination"
            } catch {
                Write-Error "An error occurred copying $($file.Name): $_"
            }
        }
    } else {
        Write-Error "The directory $scriptsDirectory does not exist."
    }
}

# Call the function with the path to the directory containing the .cmd files
ADD-My-ScriptDirectory -scriptsDirectory "D:\disk2main\mycode\my-setup\cmd"
