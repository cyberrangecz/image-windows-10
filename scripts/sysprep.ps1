
cd "C:\Program Files\Cloudbase Solutions\Cloudbase-Init\conf"
Start-Process -FilePath "C:\Windows\System32\sysprep\sysprep.exe" -ArgumentList '/generalize /oobe /unattend:Unattend.xml /quit'

# wait for sysprep to finish
while ($true) { 
    $imageState = Get-ItemProperty HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Setup\State | Select ImageState; 
    if ($imageState.ImageState -ne 'IMAGE_STATE_GENERALIZE_RESEAL_TO_OOBE') { 
        Write-Output $imageState.ImageState; Start-Sleep -s 10  
    } else { 
        break
    } 
}
