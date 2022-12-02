Invoke-Sqlcmd -Query "ALTER SERVER AUDIT [DB1LoginAudit] WITH (STATE = OFF)"
robocopy "D:\Login" "\\auditdbserver\IN\DB1\Login" /mov 
Invoke-Sqlcmd -Query "ALTER SERVER AUDIT [DB1LoginAudit] WITH (STATE = ON)"

Invoke-Sqlcmd -Query "ALTER SERVER AUDIT [DB1QueryAudit] WITH (STATE = OFF)"
robocopy "D:\Query" "\\auditdbserver\IN\DB1\Query" /mov
Invoke-Sqlcmd -Query "ALTER SERVER AUDIT [DB1QueryAudit] WITH (STATE = ON)"
