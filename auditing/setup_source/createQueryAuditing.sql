USE [master]
GO

CREATE SERVER AUDIT [DBQueryAudit]
TO FILE 
(	FILEPATH = N'E:\Query\'
	,MAXSIZE = 1024 MB
	,MAX_ROLLOVER_FILES = 5
	,RESERVE_DISK_SPACE = OFF
)
WITH
(	QUEUE_DELAY = 1000
	,ON_FAILURE = CONTINUE
	,AUDIT_GUID = '7be83fd7-9652-43d3-983b-8add274ef4ff'
)
/****** put in where clause every user which queries should not be monitored like services for ETL, etc. ******/
WHERE ([schema_name]<>'sys' AND [server_principal_name]<>'user' AND [server_principal_name]<>'domain\DBservice' AND [server_principal_name]<>'NT SERVICE\SQLTELEMETRY')
ALTER SERVER AUDIT [DBQueryAudit] WITH (STATE = ON)
GO
