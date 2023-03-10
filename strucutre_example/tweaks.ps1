#Increase the PVSCSI driver queue depth from within your Windows virtual machine by running this command (optimized for flash storage):
REG ADD HKLM\SYSTEM\CurrentControlSet\services\pvscsi\Parameters\Device /v DriverParameter /t REG_SZ /d RequestRingPages=32,MaxQueueDepth=254

#Use the following PowerShell code to verify the storage layout and block size:
Get-WmiObject Win32_Volume | select Label,Name,BlockSize | sort -Property Label

#Configure Windows TCP Parameters
#Tuning the Windows TCP parameter KeepAliveTime from the default of two hours to five minutes. This setting controls how often TCP sends a keep‐alive packet to verify that an idle connection is still intact. Reducing it from two hours to five minutes helps Windows detect and clean up stale network connections faster.
#KeepAliveTime (0x000493e0 = 300000 ms = five minutes):
REG ADD HKLM\SYSTEM\CurrentControlSet\services\tcpip\Parameters /v KeepAliveTime /t REG_DWORD /d 0x000493e0
#Tuning the Windows TCP parameter TcpTimedWaitDelay from the default of four minutes to 30 seconds. This setting determines the time that must elapse before TCP/IP can release a closed connection and reuse its resources. By reducing the value of this entry, TCP/IP can release closed connections faster and provide more resources for new connections.
#TcpTimedWaitDelay (0x0000001e = 30 seconds):
REG ADD HKLM\SYSTEM\CurrentControlSet\services\tcpip\Parameters /v TcpTimedWaitDelay /t REG_DWORD /d 0x0000001e

#Refer to the following Microsoft TechNet articles for more information about these parameters:
#KeepAliveTime: https://technet.microsoft.com/en‐us/library/cc957549.aspx 
#TcpTimedWaitDelay: https://technet.microsoft.com/en‐us/library/cc938217.aspx 
