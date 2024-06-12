Clear-Host
Write-Output "****************************************"
Write-Output "Script that sets up Virtual environment to be used in Python web scraping app"
$startDateTime=Get-Date -format "dd-MMM-yyyy HH:mm"
Write-Output "Start datetime: $startDateTime"
Write-Output ""

Write-Output "Python should be 3.11 or higher for VENV to be created successfully. Add manual path if default Python used is not correct."
Write-Output "Detecting Python versions in PATH..."

# Function to find all Python executables in PATH
function FindAllPython {
    $pythonVersions = Get-Command python | ForEach-Object { $_.FileVersionInfo.ProductVersion }
    $pythonExes = @()
    foreach ($version in $pythonVersions) {
        $pythonExes += "python$version"
    }
    return $pythonExes
}

# Print all Python executables found in PATH
$allPythonExes = FindAllPython
Write-Output "Python executables found in PATH:"
foreach ($pythonExe in $allPythonExes) {
    Write-Output $pythonExe
}

# Check all Python executables and choose the one with the highest version number
$highestVersion = [version]"0.0"
$selectedPythonExe = $null
foreach ($pythonExe in $allPythonExes) {
    $version = $pythonExe.Substring(6)  # Extract version from executable name
    $parsedVersion = [version]::new($version)
    if ($parsedVersion -ge [version]"3.11" -and $parsedVersion -gt $highestVersion) {
        $highestVersion = $parsedVersion
        $selectedPythonExe = $pythonExe
    }
}

# Check if a suitable Python version (3.11 or higher) is found
if ($selectedPythonExe) {
    Write-Output "Found suitable Python version: $selectedPythonExe. Proceeding with virtual environment creation..."
} else {
    Write-Output "No suitable Python version (3.11 or higher) found in PATH. Please ensure Python 3.11 or higher is installed and added to PATH."
    exit
}

# Create virtual environment
Write-Output ""
Write-Output "Creating Python virtual environment..."
& $selectedPythonExe -m venv .venv

# Activate virtual environment
Write-Output ""
Write-Output "Activating Python virtual environment..."
& ".\.venv\Scripts\Activate.ps1"

# Upgrade pip
Write-Output ""
Write-Output "(VENV) pip upgrade"
& $selectedPythonExe -m pip install --upgrade pip

# Install requirements
Write-Output ""
Write-Output "(VENV) Install requirements.txt"
& $selectedPythonExe -m pip install -r requirements.txt -v

Write-Output ""
Write-Output "(VENV) Install requirements-debug.txt"
& $selectedPythonExe -m pip install -r requirements-debug.txt -v

& $selectedPythonExe -m pip install -r requirements-build.txt -v

# Deactivate virtual environment
#Write-Output ""
#Write-Output "Let's deactivate Python virtual environment..."
#& ".\.venv\Scripts\deactivate.bat"
#deactivate

Write-Output ""
$endDateTime=Get-Date -format "dd-MMM-yyyy HH:mm"
Write-Output "End datetime: $endDateTime"
Write-Output "Script completed"
Write-Output "****************************************"
