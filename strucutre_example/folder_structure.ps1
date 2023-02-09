#### Central Server DB ####

# create Central Server DB directories
foreach($i in 1..4) {
mkdir M:\Central_Server_$i\mnt
}
# create tempdb directories
foreach($i in 1..2) {
mkdir M:\tempdb_$i\mnt
}
# create log directories
mkdir M:\Central_Server_Log\mnt
mkdir M:\templog\mnt

#### Central Server DB - After mounting disks ####

# create Central Server DB SQLData directories
foreach($i in 1..4) {
mkdir M:\Central_Server_$i\mnt\SQLData
}
# create tempdb directories
foreach($i in 1..2) {
mkdir M:\tempdb_$i\mnt\SQLData
}
# create log directories
mkdir M:\Central_Server_Log\mnt\SQLData
mkdir M:\templog\mnt\SQLData
