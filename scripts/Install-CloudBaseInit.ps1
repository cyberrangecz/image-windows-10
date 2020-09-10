# Check if C:\temp exists
if(!(Test-Path -Path "C:\temp"))
{
    New-Item -Path c:\ -Name temp -ItemType Directory
}

# Download CloudbaseInitSetup_Stable_x64
(New-Object System.Net.WebClient).DownloadFile('https://cloudbase.it/downloads/CloudbaseInitSetup_Stable_x64.msi','C:\temp\CloudbaseInitSetup_Stable_x64.msi')

# Start Install CloudbaseInitSetup_Stable_x64

Start-Process msiexec -ArgumentList '/i "C:\temp\CloudbaseInitSetup_Stable_x64.msi" /qb /norestart /l*v "c:\temp\install.log" USERNAME="windows" USERGROUPS="Administrators" INJECTMETADATAPASSWORD="TRUE" LOGGINGSERIALPORTNAME="COM1"' -Wait -PassThru

# Don't require changing password on first logon
Add-Content "C:\Program Files\Cloudbase Solutions\Cloudbase-Init\conf\cloudbase-init.conf" "first_logon_behaviour=no"

Write-Host "Cloudbase-Init setup done!"