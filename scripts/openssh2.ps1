# Create folder location
New-Item -Path c:\ -Name temp -ItemType Directory
# Download openssh
(New-Object System.Net.WebClient).DownloadFile('https://github.com/PowerShell/Win32-OpenSSH/releases/download/v8.1.0.0p1-Beta/OpenSSH-Win64.zip','C:\temp\OpenSSH-Win64.zip')
# Unzip the files
Expand-Archive -Path "c:\temp\OpenSSH-Win64.Zip" -DestinationPath "C:\Program Files\OpenSSH"
# Install service
. "C:\Program Files\OpenSSH\OpenSSH-Win64\install-sshd.ps1"
# Set firewall permissions
New-NetFirewallRule -Name sshd -DisplayName 'OpenSSH Server (sshd)' -Enabled True -Direction Inbound -Protocol TCP -Action Allow -LocalPort 22

# Set service startup
Set-Service sshd -StartupType Automatic
Start-Service sshd

# Set Authentication to public key
((Get-Content -path C:\ProgramData\ssh\sshd_config -Raw) `
-replace '#PubkeyAuthentication yes','PubkeyAuthentication yes' `
-replace '#PasswordAuthentication yes','PasswordAuthentication no' `
-replace 'Match Group administrators','#Match Group administrators' `
-replace 'AuthorizedKeysFile __PROGRAMDATA__/ssh/administrators_authorized_keys','#AuthorizedKeysFile __PROGRAMDATA__/ssh/administrators_authorized_keys') | Set-Content -Path C:\ProgramData\ssh\sshd_config


# Restart after changes
Restart-Service sshd


# force file creation
New-item -Path $env:USERPROFILE -Name .ssh -ItemType Directory -force

# Copy key
Write-Output "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDhiZRfeiepdFIMEx5Lp1QTxiB1VwFzMg8kQd08EVIehbgonMoNZ8DTyqjiTgX2brkEwoAc05ii73vjbyAuC3V+7hboRVPV+ReDy7VWBd/PYBdI92ZWGGLYwL/B+WtmUf1T6UJ4RlO4z0vRGONh1L7AWJGKQXGfvh0MLocgfjOgOputkp3QwHLD08cLRLHzY+F7V85ocO5++yZ6jlGN5JrDon9SxJg8kl6D40NMh1Mw95ib58sgBSXV+LdS+8BdYuW0nLZmiweaJCcoJSKg+VF57KD0QcgBjjg6Np+43LBrZmNZwBh5fSbTOpz0KmxcnOVVY0ui4Kv1I3wG9WY3eGc1 kaco@kacvinsky-GL503VM
" | Out-File $env:USERPROFILE\.ssh\authorized_keys -Encoding ascii
