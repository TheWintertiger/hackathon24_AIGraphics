Clear-Host
Write-Output "****************************************"
Write-Output "Script that sets up Virtual environment to be used"
$startDateTime=Get-Date -format "dd-MMM-yyyy HH:mm"
Write-Output "Start datetime: $startDateTime"
Write-Output ""

Write-Output "Python should be 3.11 or higher for VENV to be created successfully. Add manual path if default Python used is not correct."
Write-Output "Detecting Python version in PATH..."

# Function to find Python executables with version 3.11 or higher
function FindPython {
    $pythonVersions = Get-Command python | ForEach-Object { $_.FileVersionInfo.ProductVersion }
    foreach ($version in $pythonVersions) {
        if ([version]$version -ge [version]"3.11") {
            return "python$version"
        }
    }
    return $null
}

# Check if Python executable with version 3.11 or higher is found
$pythonExe = FindPython
if ($pythonExe) {
    Write-Output "Found suitable Python version: $pythonExe. Proceeding with virtual environment creation..."
} else {
    Write-Output "No suitable Python version (3.11 or higher) found in PATH. Please ensure Python 3.11 or higher is installed and added to PATH."
    exit
}

# Create virtual environment
Write-Output ""
Write-Output "Creating Python virtual environment..."
& $pythonExe -m venv .venv

# Activate virtual environment
Write-Output ""
Write-Output "Activating Python virtual environment..."
.\.venv\Scripts\Activate.ps1

# Upgrade pip
Write-Output ""
Write-Output "(VENV) pip upgrade"
& $pythonExe -m pip install --upgrade pip

# Install requirements
Write-Output ""
Write-Output "(VENV) Install requirements.txt"
& $pythonExe -m pip install -r requirements.txt -v

Write-Output ""
Write-Output "(VENV) Install requirements-debug.txt"
& $pythonExe -m pip install -r requirements-debug.txt -v

& $pythonExe -m pip install -r requirements-build.txt -v

# Deactivate virtual environment
#Write-Output ""
#Write-Output "Let's deactivate Python virtual environment..."
#.\.venv\Scripts\deactivate.bat
#deactivate

Write-Output ""
$endDateTime=Get-Date -format "dd-MMM-yyyy HH:mm"
Write-Output "End datetime: $endDateTime"
Write-Output "Script completed"
Write-Output "****************************************"
