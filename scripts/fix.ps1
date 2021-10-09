# Set Powershell as default line
New-ItemProperty -Path "HKLM:\SOFTWARE\OpenSSH" -Name DefaultShell -Value "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe" -PropertyType String -Force

# Disable Administrator account
net user administrator /active:no

# Allow ICMP ping in firewall
netsh advfirewall firewall add rule name="ICMP Allow incoming V4 echo request" protocol=icmpv4:8,any dir=in action=allow
netsh advfirewall firewall add rule name="ICMP Allow incoming V6 echo request" protocol=icmpv6:8,any dir=in action=allow

# Use muni ntp server
Push-Location
Set-Location HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\DateTime\Servers
Set-ItemProperty . 0 "ntp1.muni.cz"
Set-ItemProperty . "(Default)" "0"
Set-Location HKLM:\SYSTEM\CurrentControlSet\services\W32Time\Parameters
Set-ItemProperty . NtpServer "ntp1.muni.cz"
Pop-Location
Stop-Service w32time
Start-Service w32time
