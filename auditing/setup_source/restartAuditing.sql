--- Set up a daily job to restart auditing at 23:59:59

USE msdb ;  
GO  
EXEC dbo.sp_add_job  
    @job_name = N'Restart Auditing' ;  
GO  
EXEC sp_add_jobstep  
    @job_name = N'Restart Auditing',  
    @step_name = N'Stop Login Auditing',  
    @subsystem = N'TSQL',  
    @command = N'ALTER SERVER AUDIT [DBLoginAudit] WITH (STATE = OFF)',   
    @retry_attempts = 5,  
    @retry_interval = 5 ;  
GO  
EXEC sp_add_jobstep  
    @job_name = N'Restart Auditing',  
    @step_name = N'Start Login Auditing',  
    @subsystem = N'TSQL',  
    @command = N'ALTER SERVER AUDIT [DBLoginAudit] WITH (STATE = ON)',   
    @retry_attempts = 5,  
    @retry_interval = 5 ;  
GO
EXEC sp_add_jobstep  
    @job_name = N'Restart Auditing',  
    @step_name = N'Stop Query Auditing',  
    @subsystem = N'TSQL',  
    @command = N'ALTER SERVER AUDIT [DBQueryAudit] WITH (STATE = OFF)',   
    @retry_attempts = 5,  
    @retry_interval = 5 ;  
GO  
EXEC sp_add_jobstep  
    @job_name = N'Restart Auditing',  
    @step_name = N'Start Query Auditing',  
    @subsystem = N'TSQL',  
    @command = N'ALTER SERVER AUDIT [DBQueryAudit] WITH (STATE = ON)',   
    @retry_attempts = 5,  
    @retry_interval = 5 ;  
GO
EXEC dbo.sp_add_schedule  
    @schedule_name = N'Daily',  
    @freq_type = 4,  
    @active_start_time = 235959 ;  
USE msdb ;  
GO  
EXEC sp_attach_schedule  
   @job_name = N'Restart Auditing',  
   @schedule_name = N'Daily';  
GO  
EXEC dbo.sp_add_jobserver  
    @job_name = N'Restart Auditing';  
GO
