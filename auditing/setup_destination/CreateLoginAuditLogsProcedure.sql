CREATE PROCEDURE [dbo].[SqlAuditCaptureLoginAuditLogs]
AS
BEGIN
    SET XACT_ABORT ON

    INSERT INTO DB_Audit.[dbo].[SQLAUDIT_LOGIN] (
        event_time
        ,sequence_number
        ,succeeded
        ,action_id
        ,server_principal_name
        ,server_instance_name
        ,statement
        ,client_ip
        ,application_name
        )
    SELECT event_time
        ,sequence_number
        ,succeeded
        ,action_id
        ,server_principal_name
        ,server_instance_name
        ,statement
        ,client_ip
        ,application_name
    FROM sys.fn_get_audit_file('D:\IN\login\*.*', DEFAULT, DEFAULT)
#    WHERE server_principal_name NOT IN (
#            'mfoperational'
#			,'dba-admin'
#            )
END
