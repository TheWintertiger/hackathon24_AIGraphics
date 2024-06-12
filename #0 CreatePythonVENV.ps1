Clear-Host
Write-Output "****************************************"
Write-Output "Script that sets up Virtual environment to be used in Python web scraping app"
$startDateTime=Get-Date -format "dd-MMM-yyyy HH:mm"
Write-Output "Start datetime: $startDateTime"
Write-Output ""
Write-Output "Python should be 3.6 or higher for VENV to be created sucesfully. Add manuall path if default Python used is not correct."
Write-Output "Detect Python version in PATH"
python -V
#pause

Write-Output ""
Write-Output "Creating Python virtual environment..."
python -m venv .venv

Write-Output ""
Write-Output "Activating Python virtual environment..."
.\.venv\Scripts\Activate.ps1

#Get-Command python | fl *   
Write-Output ""
Write-Output "(VENV) Used Python:"
Get-Command python | Format-Table Definition

Write-Output ""
Write-Output "(VENV) pip upgrade"
python -m pip install --upgrade pip

Write-Output ""
Write-Output "(VENV) Install requirements.txt"
python -m pip install -r requirements.txt -v

Write-Output ""
Write-Output "(VENV) Install requirements-debug.txt"
python -m pip install -r requirements-debug.txt -v

python -m pip install -r requirements-build.txt -v

#Write-Output ""
#Write-Output "Let's deactivate Python virtaul environment..."
#.\.venv\Scripts\deactivate.bat
#deactivate


Write-Output ""
$endDateTime=Get-Date -format "dd-MMM-yyyy HH:mm"
Write-Output "End datetime: $endDateTime"
Write-Output "Script completed"
Write-Output "****************************************"
# comment