# Check if C:\temp exists
if(!(Test-Path -Path "C:\temp"))
{
    New-Item -Path c:\ -Name temp -ItemType Directory
}

# Download CloudbaseInitSetup_Stable_x64
(New-Object System.Net.WebClient).DownloadFile('https://cloudbase.it/downloads/CloudbaseInitSetup_Stable_x64.msi','C:\temp\CloudbaseInitSetup_Stable_x64.msi')

# Start Install CloudbaseInitSetup_Stable_x64

Start-Process msiexec -ArgumentList '/i "C:\temp\CloudbaseInitSetup_Stable_x64.msi" /qb /norestart /l*v "c:\temp\install.log" USERNAME="windows" USERGROUPS="Administrators" INJECTMETADATAPASSWORD="TRUE" LOGGINGSERIALPORTNAME="COM1"' -Wait -PassThru

# Don't require changing password on first logon, disable winrm basic auth and http listener
Add-Content "C:\Program Files\Cloudbase Solutions\Cloudbase-Init\conf\cloudbase-init.conf" '
first_logon_behaviour=no
activate_windows=true
real_time_clock_utc=true
ntp_enable_service=true
ntp_use_dhcp_config=false
ntp_servers=time.windows.com
plugins=cloudbaseinit.plugins.common.mtu.MTUPlugin, cloudbaseinit.plugins.windows.ntpclient.NTPClientPlugin, cloudbaseinit.plugins.windows.createuser.CreateUserPlugin, cloudbaseinit.plugins.common.networkconfig.NetworkConfigPlugin, cloudbaseinit.plugins.common.setuserpassword.SetUserPasswordPlugin, cloudbaseinit.plugins.common.localscripts.LocalScriptsPlugin, cloudbaseinit.plugins.windows.winrmcertificateauth.ConfigWinRMCertificateAuthPlugin, cloudbaseinit.plugins.common.sshpublickeys.SetUserSSHPublicKeysPlugin, cloudbaseinit.plugins.windows.extendvolumes.ExtendVolumesPlugin, cloudbaseinit.plugins.common.userdata.UserDataPlugin, cloudbaseinit.plugins.windows.licensing.WindowsLicensingPlugin
metadata_services=cloudbaseinit.metadata.services.configdrive.ConfigDriveService, cloudbaseinit.metadata.services.httpservice.HttpService
'

# Set registry key so SetUserPasswordPlugin doesn't run on reboot even if it fails
New-Item -Path "C:\Program Files\Cloudbase Solutions\Cloudbase-Init\LocalScripts" -Name "SetUserPasswordPlugin-fix.ps1" -ItemType "file" -Value '
$p = reg query "HKLM\SOFTWARE\Cloudbase Solutions\Cloudbase-Init"
reg add "$p\Plugins" /v SetUserPasswordPlugin /t REG_DWORD /d 1 /f
'

# Wait for WinRM to start to be able to set WinRM auth certificate
New-Item -Path "C:\Program Files\Cloudbase Solutions\Cloudbase-Init\LocalScripts" -Name "WaitForWinRM.ps1" -ItemType "file" -Value '
$timeout = 300
$retryInterval = 5
$startTime = Get-Date
while ((Get-Date) -lt $startTime.AddSeconds($timeout)) {
    try {
        $winRMTest = Test-WSMan -ErrorAction Stop

        if ($winRMTest) {
            Write-Host "WinRM is available."
            break
        }
    }
    catch {
        Write-Host "WinRM is not available yet. Retrying in $retryInterval seconds..."
    }

    Start-Sleep -Seconds $retryInterval
}

if ((Get-Date) -ge $startTime.AddSeconds($timeout)) {
    Write-Host "Timeout: WinRM is still not available after $timeout seconds."
}
'

$localScriptsPath = "C:\Program Files\Cloudbase Solutions\Cloudbase-Init\LocalScripts"

# ==============================
# sync-time.ps1 content
# ==============================
$scriptContent = @'
# Allow large time corrections (up to 12 hours)
w32tm /config /update /maxposphasecorrection:43200 /maxnegphasecorrection:43200

# Stop, unregister, re-register, and start Windows Time service
net stop w32time
w32tm /unregister
w32tm /register
net start w32time

# Define NTP servers
$ntpServers = "time.windows.com,0x9 0.pool.ntp.org,0x9 1.pool.ntp.org,0x9"

# Retry NTP sync multiple times with short delay
for ($i = 1; $i -le 5; $i++) {
    Write-Host "Attempt $i: Configuring NTP servers and forcing resync..."
    w32tm /config /manualpeerlist:$ntpServers /syncfromflags:manual /update
    Start-Sleep -Seconds 10
    try {
        w32tm /resync /force
        Write-Host "Resync command sent successfully."
        break
    }
    catch {
        Write-Host "Resync attempt $i failed. Retrying..."
    }
}

# Show final status
Write-Host "Final NTP status:"
w32tm /query /status
'@

# Create the script file safely
New-Item -LiteralPath "$localScriptsPath\sync-time.ps1" -ItemType File -Value $scriptContent -Force

Write-Host "Cloudbase-Init setup done!"
