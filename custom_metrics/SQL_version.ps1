# Get SQL version
Write-Verbose -Message "Get SQL version..."
$FullVersion=Invoke-Sqlcmd -Query "SELECT @@VERSION;" -QueryTimeout 3

#If the previous command fails (no default instance), then look for the first instance
if (!$FullVersion)
{
    $FirstInstance=(get-itemproperty 'HKLM:\SOFTWARE\Microsoft\Microsoft SQL Server').InstalledInstances[0]
    if ($FirstInstance)
    {
    	$FullVersion=Invoke-Sqlcmd -ServerInstance "localhost\$FirstInstance" -Query "SELECT @@VERSION;" -QueryTimeout 3
    }
}

# If Version is found
if ($FullVersion)
{
# Do some cleanup of the output
	$SplitedOnSpace=($FullVersion | Select-Object -ExpandProperty Column1 | Out-String).Trim().Split(" ")
  $SplitedOnParenthesis=$SplitedOnSpace[4].Split("()")

# Insert here a call to the monitoring API
#SQL Majour version: $SplitedOnSpace[3]
#SQL CU version: $SplitedOnParenthesis[1]

}
else
{
	Write-Warning -Message "No SQL version found!"
	return 1
}
