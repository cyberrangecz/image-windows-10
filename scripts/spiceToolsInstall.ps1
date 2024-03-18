
certutil -AddStore "TrustedPublisher" "a:\redhat.cer"
Start-Process -FilePath "C:\Windows\Temp\spice-guest-tools.exe" -ArgumentList "/S" -Wait
