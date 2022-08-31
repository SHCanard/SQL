USE [master]
GO

CREATE SERVER AUDIT [DBLoginAudit]
TO FILE
(	FILEPATH = N'E:\Login\'
	,MAXSIZE = 1024 MB
	,MAX_ROLLOVER_FILES = 5
	,RESERVE_DISK_SPACE = OFF
)
WITH
(	QUEUE_DELAY = 1000
	,ON_FAILURE = CONTINUE
	,AUDIT_GUID = 'a83fd3b6-6ce3-43e9-abec-7227d0d8cd52'
)
/****** put in where clause every user which login should not be monitored like services for backups, ETL, etc. ******/
WHERE ([server_principal_name]<>'domain\DBservice' AND [server_principal_name]<>'user' AND [server_principal_name]<>'NT SERVICE\SQLTELEMETRY' AND [server_principal_name]<>'NT AUTHORITY\SYSTEM')
ALTER SERVER AUDIT [DBLoginAudit] WITH (STATE = ON)
GO
