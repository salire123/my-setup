markdown
# PowerShell Scripts for Environment Backup and Restoration

This repository contains two PowerShell scripts that are used for backing up and restoring a development environment on Windows. The `export.ps1` script is used to export configurations and settings, while the `run.ps1` script is used to install necessary tools and import settings.

## export.ps1

The `export.ps1` script is responsible for exporting the following items:

- Chocolatey packages to a configuration file.
- Visual Studio Code extensions to a text file.
- Visual Studio Code settings and keybindings to JSON files.

### Usage

To use the `export.ps1` script, simply run it from a PowerShell prompt:

```powershell
.\export.ps1
````

This will create a `config-save` directory with the exported files.

## run.ps1

The `run.ps1` script performs the following actions:

- Checks if the script is running with administrator privileges.
- Installs Chocolatey if it is not already installed.
- Installs packages from a Chocolatey configuration file.
- Updates the system's environment PATH variable.
- Installs Visual Studio Code extensions from a list.
- Uploads Visual Studio Code settings from a JSON file.

### Usage

Before running the `run.ps1` script, make sure to run PowerShell as an administrator. Then execute the script:

```powershell
.\run.ps1
```

The script will log its actions to a `log` directory, creating an `install.log` file with timestamps for each logged event.

## Notes

- Ensure that you have the necessary permissions to execute scripts on your system.
- It is recommended to review the scripts and understand the actions they perform before running them.
- Always back up your current configurations before running the `run.ps1` script to avoid accidental loss of data.

## Contributing

If you would like to contribute to these scripts or suggest improvements, please feel free to open an issue or submit a pull request.
