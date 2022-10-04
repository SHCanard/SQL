# Executed on the audited server, moves audit files to the input dir of the server sotcking audits in DB

robocopy "D:\Login" "\\auditdbserver\IN\DB1\Login" /mov /minlad:1
robocopy "D:\Query" "\\auditdbserver\IN\DB1\Query" /mov /minlad:1

# /minlad:<n>	Excludes files with a Last Access Date newer than n days or specified date. If n is less than 1900, then n is expressed in days. Otherwise, n is a date expressed as YYYYMMDD.
