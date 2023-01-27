#Set the execution to stop after an error occurred
$ErrorActionPreference = 'Stop'

#Get Current month and year
$month = (Get-Date).Month
$year = (Get-Date).Year

# Connect to the SQL server
$conn = New-Object System.Data.SqlClient.SqlConnection
$conn.ConnectionString = "Server=localhost;Database=DB_Audit;Trusted_Connection=True;"
$conn.Open()

# Create the SQL command to execute the delete procedure on Login
$cmdLogin = New-Object System.Data.SqlClient.SqlCommand
$cmdLogin.Connection = $conn
$cmdLogin.CommandText = "DELETE FROM SQLAUDIT_LOGIN WHERE event_time < '$dateThreshold'"

# Create the SQL command to execute the delete procedure on Query
$cmdQuery = New-Object System.Data.SqlClient.SqlCommand
$cmdQuery.Connection = $conn
$cmdQuery.CommandText = "DELETE FROM SQLAUDIT_QUERY WHERE event_time < '$dateThreshold'"

# Execute the delete procedure on Login
Try
{
    $rowsDeletedL=$cmdLogin.ExecuteNonQuery()
}
Catch
{
    # Log the error message to the log file
    Add-Content -Path "$PSScriptRoot/logs/$year-$month.QueryDBAuditLogs_delete_errors.log" -Value $(Get-Date)
    Add-Content -Path "$PSScriptRoot/logs/$year-$month.QueryDBAuditLogs_delete_errors.log" -Value $Error[0]
    Add-Content -Path "$PSScriptRoot/logs/$year-$month.QueryDBAuditLogs_delete_errors.log" -Value "---"
    move D:\IN\Clarity_PRD\Query\*.* D:\OUT\KO
}

# Log a success message to the log file
Add-Content -Path "$PSScriptRoot/logs/$year-$month.QueryDBAuditLogs_delete_success.log" -Value $(Get-Date)
Add-Content -Path "$PSScriptRoot/logs/$year-$month.QueryDBAuditLogs_delete_success.log" -Value "Delete procedure successful on Login, $rowsDeletedL rows deleted"
Add-Content -Path "$PSScriptRoot/logs/$year-$month.QueryDBAuditLogs_delete_success.log" -Value "---"

# Execute the delete procedure on Query
Try
{
    $rowsDeletedQ=$cmdQuery.ExecuteNonQuery()
}
Catch
{
    # Log the error message to the log file
    Add-Content -Path "$PSScriptRoot/logs/$year-$month.QueryDBAuditLogs_delete_errors.log" -Value $(Get-Date)
    Add-Content -Path "$PSScriptRoot/logs/$year-$month.QueryDBAuditLogs_delete_errors.log" -Value $Error[0]
    Add-Content -Path "$PSScriptRoot/logs/$year-$month.QueryDBAuditLogs_delete_errors.log" -Value "---"
}
Finally
{
    # Close the connection to the SQL server
    $conn.Close()
}

# Log a success message to the log file
Add-Content -Path "$PSScriptRoot/logs/$year-$month.QueryDBAuditLogs_delete_success.log" -Value $(Get-Date)
Add-Content -Path "$PSScriptRoot/logs/$year-$month.QueryDBAuditLogs_delete_success.log" -Value "Delete procedure successful on Query, $rowsDeletedQ rows deleted"
Add-Content -Path "$PSScriptRoot/logs/$year-$month.QueryDBAuditLogs_delete_success.log" -Value "---"
