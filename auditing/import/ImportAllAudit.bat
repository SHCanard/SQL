SET mypath=%~dp0

CALL sqlcmd -E -d DB_Audit -i "%mypath%ImportQueryAuditLogs.sql" -o "%mypath%QueryDBAuditLogs.log"
move D:\IN\DB1\Query\*.* D:\OUT
CALL sqlcmd -E -d DB_Audit -i "%mypath%ImportLoginAuditLogs.sql" -o "%mypath%LoginDBAuditLogs.log"
move D:\IN\DB1\Login\*.* D:\OUT
