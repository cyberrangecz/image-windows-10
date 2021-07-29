# Enable WinRM basic auth and allow_unencrypted
Set-Item -Path "WSMan:\localhost\Service\Auth\Basic" -Value $true
Set-Item -Path "WSMan:\localhost\Service\AllowUnencrypted" -Value $true
