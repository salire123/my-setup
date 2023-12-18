
## Prerequisites

Before proceeding, make sure you have administrative access to your PC and that you are comfortable executing scripts and commands that alter your system configuration.

### Step 1: Set Execution Policy for PowerShell Scripts

PowerShell's execution policy is a safety feature that controls the conditions under which PowerShell loads configuration files and runs scripts. This step is crucial to allow our setup script to run without any restrictions.

1. Open PowerShell as an Administrator. You can do this by typing "PowerShell" into the Start menu, right-clicking on Windows PowerShell, and selecting "Run as Administrator".
2. Enter the following command:

   ```powershell
   Set-ExecutionPolicy RemoteSigned
   ```

3. You will be prompted to confirm the change. Press `Y` and then `Enter` to confirm.

This sets the policy to allow scripts to run that have been downloaded from the Internet with a trusted signature.

### Step 2: Install Git

Git is a distributed version control system that is essential for tracking changes in source code during software development.

1. Still in the Administrator PowerShell window, install Git using the Windows package manager `winget` with the following command:

   ```powershell
   winget install git
   ```

2. Follow any on-screen prompts to complete the installation process.

Make sure your `winget` command line tool is up-to-date before running this command.

### Step 3: Clone the Setup Repository

Before running the setup script, you need to clone the repository containing the `run.ps1` script.

1. Still in the Administrator PowerShell window, enter the following command:

   ```powershell
   git clone https://github.com/salire123/my-setup.git
   ```

2. Navigate to the newly created directory, which contains the `run.ps1` script:

   ```powershell
   cd my-setup
   ```

### Step 4: Run the Setup Script

Finally, we will execute the custom setup script named `run.ps1`. Ensure that the `run.ps1` file is in your current directory.

1. In the Administrator PowerShell window, ensure you are in the directory where `run.ps1` is located.
2. Execute the script with the following command:

   ```powershell
   .\run.ps1
   ```

Continue with any additional instructions provided by the script.

