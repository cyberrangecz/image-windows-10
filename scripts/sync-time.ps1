# Allow large time corrections (e.g., up to 12 hours)
w32tm /config /update /maxposphasecorrection:43200 /maxnegphasecorrection:43200
# Re-register time service to ensure correct state
net stop w32time
w32tm /unregister
w32tm /register
net start w32time
# Force multiple resyncs with a short delay between each
$peers = "time.windows.com,0x9"
for ($i=0; $i -lt 5; $i++) {
    w32tm /config /manualpeerlist:$peers /syncfromflags:manual /update
    Start-Sleep -Seconds 10
    w32tm /resync /force
}
