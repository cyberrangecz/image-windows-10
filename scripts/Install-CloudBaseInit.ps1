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
winrm_configure_http_listener=False
winrm_enable_basic_auth=False
plugins=cloudbaseinit.plugins.common.mtu.MTUPlugin, cloudbaseinit.plugins.windows.ntpclient.NTPClientPlugin, cloudbaseinit.plugins.common.sethostname.SetHostNamePlugin, cloudbaseinit.plugins.windows.createuser.CreateUserPlugin, cloudbaseinit.plugins.common.networkconfig.NetworkConfigPlugin, cloudbaseinit.plugins.common.setuserpassword.SetUserPasswordPlugin, cloudbaseinit.plugins.windows.winrmlistener.ConfigWinRMListenerPlugin, cloudbaseinit.plugins.windows.winrmcertificateauth.ConfigWinRMCertificateAuthPlugin, cloudbaseinit.plugins.common.sshpublickeys.SetUserSSHPublicKeysPlugin, cloudbaseinit.plugins.windows.extendvolumes.ExtendVolumesPlugin, cloudbaseinit.plugins.common.userdata.UserDataPlugin, cloudbaseinit.plugins.common.localscripts.LocalScriptsPlugin, cloudbaseinit.plugins.windows.licensing.WindowsLicensingPlugin
'

# Set registry key so SetUserPasswordPlugin doesn't run on reboot even if it fails
New-Item -Path "C:\Program Files\Cloudbase Solutions\Cloudbase-Init\LocalScripts" -Name "SetUserPasswordPlugin-fix.ps1" -ItemType "file" -Value '
$p = reg query "HKLM\SOFTWARE\Cloudbase Solutions\Cloudbase-Init"
reg add "$p\Plugins" /v SetUserPasswordPlugin /t REG_DWORD /d 1 /f
'

Write-Host "Cloudbase-Init setup done!"
