CREATE TABLE [dbo].[SQLAUDIT_QUERY](
 [event_time] [datetime2](7) NULL,
 [sequence_number] [int] NULL,
 [action_id] [varchar](4) NULL,
 [server_principal_name] [nvarchar](100) NULL,
 [server_instance_name] [nvarchar](100) NULL,
 [database_name] [nvarchar](100) NULL,
 [schema_name] [nvarchar](100) NULL,
 [object_name] [nvarchar](100) NULL,
 [statement] [nvarchar](max) NULL
 )

CREATE TABLE [dbo].[SQLAUDIT_LOGIN](
 [event_time] [datetime2](7) NULL,
 [sequence_number] [int] NULL,
 [succeeded] [bit] NOT NULL,
 [action_id] [varchar](4) NULL,
 [server_principal_name] [nvarchar](100) NULL,
 [server_instance_name] [nvarchar](100) NULL,
 [statement] [nvarchar](max) NULL,
 [client_ip] [nvarchar](max) NULL,
 [application_name] [nvarchar](max) NULL
 )
