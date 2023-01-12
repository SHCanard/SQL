# Import the SQL Server PowerShell module
#Import-Module sqlserver

#Set the execution to stop after an error occurred
$ErrorActionPreference = 'Stop'

#Get Current month and year
$month = (Get-Date).Month
$year = (Get-Date).Year

## Import Login Audit logs

# Connect to the SQL server
$conn = New-Object System.Data.SqlClient.SqlConnection
$conn.ConnectionString = "Server=localhost;Database=DB_Audit;Trusted_Connection=True;"
$conn.Open()

# Create the SQL command to execute the insert procedure
$cmd = New-Object System.Data.SqlClient.SqlCommand
$cmd.Connection = $conn
$cmd.CommandText = "EXECUTE dbo.SqlAuditCaptureLoginAuditLogs"

# Execute the insert procedure
Try
{
    $rowsInserted=$cmd.ExecuteNonQuery()
}
Catch
{
    # Log the error message to the log file
    Add-Content -Path "$PSScriptRoot/logs/$year-$month.LoginAuditLogs_errors.log" -Value $(Get-Date)
    Add-Content -Path "$PSScriptRoot/logs/$year-$month.LoginAuditLogs_errors.log" -Value $Error[0]
    Add-Content -Path "$PSScriptRoot/logs/$year-$month.LoginAuditLogs_errors.log" -Value "---"
    move D:\IN\DB\Login\*.* D:\OUT\KO
}
Finally
{
    # Close the connection to the SQL server
    $conn.Close()
}

# Log a success message to the log file
Add-Content -Path "$PSScriptRoot/logs/$year-$month.LoginAuditLogs_success.log" -Value $(Get-Date)
Add-Content -Path "$PSScriptRoot/logs/$year-$month.LoginAuditLogs_success.log" -Value "Insert procedure successful, $rowsInserted rows inserted"
Add-Content -Path "$PSScriptRoot/logs/$year-$month.LoginAuditLogs_success.log" -Value "---"
move D:\IN\DB\Login\*.* D:\OUT\OK
