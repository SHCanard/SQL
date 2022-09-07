CREATE PROCEDURE [dbo].[SqlAuditCaptureQueryAuditLogs]
AS
BEGIN
    SET XACT_ABORT ON

    INSERT INTO DB_Audit.[dbo].[SQLAUDIT_QUERY] (
        event_time
        ,sequence_number
        ,action_id
        ,server_principal_name
        ,server_instance_name
        ,database_name
        ,schema_name
        ,object_name
        ,statement
        )
    SELECT event_time
        ,sequence_number
        ,action_id
        ,server_principal_name
        ,server_instance_name
        ,database_name
        ,schema_name
        ,object_name
        ,statement
    FROM sys.fn_get_audit_file('D:\IN\Query\*.*', DEFAULT, DEFAULT)
END
