--- Set up a daily job to restart auditing at 23:59:59
--- Dirty way to rotate sqlaudit files daily

USE msdb ;  
GO  
EXEC dbo.sp_add_job  
    @job_name = N'Restart Login Auditing' ;  
GO  
EXEC sp_add_jobstep  
    @job_name = N'Restart Login Auditing',  
    @step_name = N'Stop Login Auditing',  
    @subsystem = N'TSQL',  
    @command = N'ALTER SERVER AUDIT [DBLoginAudit] WITH (STATE = OFF)',   
    @on_success_action = 3,  
    @retry_attempts = 5,  
    @retry_interval = 5 ;  
GO  
EXEC sp_add_jobstep  
    @job_name = N'Restart Login Auditing',  
    @step_name = N'Start Login Auditing',  
    @subsystem = N'TSQL',  
    @command = N'ALTER SERVER AUDIT [DBloginAudit] WITH (STATE = ON)',   
    @retry_attempts = 5,  
    @retry_interval = 5 ;  
GO
EXEC dbo.sp_add_schedule  
    @schedule_name = N'Daily Restart Login Auditing',  
    @freq_type = 4,  
    @freq_interval = 1,  
    @active_start_time = 235959 ;  
USE msdb ;  
GO  
EXEC sp_attach_schedule  
   @job_name = N'Restart Login Auditing',  
   @schedule_name = N'Daily Restart Login Auditing';  
GO  
EXEC dbo.sp_add_jobserver  
    @job_name = N'Restart Login Auditing';  
GO
