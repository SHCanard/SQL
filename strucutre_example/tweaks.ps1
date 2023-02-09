#Increase the PVSCSI driver queue depth from within your Windows virtual machine by running this command (optimized for flash storage):
REG ADD HKLM\SYSTEM\CurrentControlSet\services\pvscsi\Parameters\Device /v DriverParameter /t REG_SZ /d RequestRingPages=32,MaxQueueDepth=254

#Use the following PowerShell code to verify the storage layout and block size:
Get-WmiObject Win32_Volume | select Label,Name,BlockSize | sort -Property Label
