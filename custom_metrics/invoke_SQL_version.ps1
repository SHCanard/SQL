<#
*******************************************************************************

 Parameters:	-LocalHost : no value, set target as host running this script
				-ComputerName : string, target hostname
				-ServerListFile : string, path to Epic style ServerList.txt
				**Only one of the three above is required**
				-Context : string, should be used only with "-ServerListFile", default value if omitted is "Common",
					you can use the value "ALL" to go through all possible contexts
 
 Outputs:	Display verbose and warning messages.
			  Return 0 if call of script on specified host(s) is successfull.
			  Return 1 if a least one host failed.
 
 Assumes:	Invoked script should keep its original name and be in the same place as this script.
			  If not, update the variable "[string] $scriptLocalPath" with the right value.
 
 Example:	powershell invoke_push_SQL_version.ps1 -LocalHost
			powershell invoke_push_SQL_version.ps1 -ComputerName server1
			powershell invoke_push_SQL_version.ps1 -ServerListFile c:\temp\ServerList.txt -Context sql_servers
 
  *******************************************************************************
 #>

Param
(
	# path to the file containing the list of servers and contexts
	[Parameter(Mandatory=$false,ParameterSetName='ServerListFile')]
	$serverListFile,

	# name of the machine(s) for which to run the script
	[Parameter(Mandatory=$false,ParameterSetName='ComputerName')]
	$computerName,

	# switch for running the script only on the local machine
	[Parameter(Mandatory=$false,ParameterSetName='LocalHost')]
	[switch] $localHost,

	# context for which product(s) to get configuration data for
	[Parameter(Mandatory=$false)]
	$context = @('Common')
)

[string] $scriptLocalPath="$PSScriptRoot\SQL_version.ps1"

<#
.Synopsis
   Parses the ServerList.txt file and outputs an array of ServerName
#>
function GetServerList
{
	[CmdletBinding()]
	Param
	(
		[Parameter(Mandatory=$true)]
		[string] $serverListFile
	)

	if (Test-Path $serverListFile)
	{
		$serversToProcess = @()
		Get-Content $serverListFile | ForEach-Object {
			if ($_.StartsWith('#'))
			{
				# do nothing - these are comments
			}
			elseif ($_.StartsWith('['))
			{
				$ctxt = $_.Substring($_.IndexOf('[')+1,$_.IndexOf(']')-1)
				if($context -contains $ctxt)
				{
					$ReadContext = "same"
				}
				elseif ($context -eq "ALL")
				{
					$ReadContext = "same"
				}
				else
				{
					$ReadContext = "different"
				}
			}
			elseif ($ReadContext -eq "same")
			{
				if (-not [string]::IsNullOrWhiteSpace($_))
				{
					$serversToProcess += "$($_.Trim())"
				}
			}
		}
		if ($serversToProcess.Count -gt 0)
		{
			$serversToProcess = $serversToProcess | Select-Object -Unique
			Write-Verbose -Message "$($serversToProcess.Count) servers found in ServerList.txt"
			return $serversToProcess
		}
		else
		{
			Write-Verbose -Message "No servers found in ServerList.txt."
			return $null
		}
	}
	else
	{
		Write-Warning -Message "Invalid path to ServerList.txt specified: $serverListFile"
		return $null
	}
}

## Begin----

#If a ServerList file is given in parameter
if ($PSCmdlet.ParameterSetName -eq "ServerListFile")
{
	# Check to see if $serverListFile is missing directory path due to calling the script with dot-sourcing and re-assign the correct value if it is
	if($serverListFile -eq "\ServerList.txt")
	{
		$serverListFile = "$PSScriptRoot\ServerList.txt"
	}

	Write-Verbose -Message "ServerListFile: $serverListFile"
	
	if (Test-Path -Path $serverListFile)
	{
		Write-Debug -Message "Contents of ServerList.txt:"
		Get-Content $serverListFile | ForEach-Object {Write-Debug -Message $_}
	}
	else
	{
		Write-Warning -Message "Invalid path specified for the ServerListFile."
		Write-Warning -Message "Please specify a valid path and retry."
		return 1
	}

	Write-Verbose -Message "Loading the ServerList.txt file for the list of servers on which to invoke the script."
	$serversToProcess = GetServerList -ServerListFile $serverListFile

	if ($serversToProcess.Count -eq 0)
	{
		# No servers specified in ServerList.txt
		Write-Warning -Message "ServerListFile is empty for Context $context!"
		return 1
	}
	else
	{
		$failed=0
		foreach ($computerName in $serversToProcess)
		{
			Write-Verbose -Message "ComputerName: $computerName" -Verbose
			Write-Verbose -Message "Context: $context" -Verbose
			# Invoke the script on each Computer Name get from ServerList
			$output=Invoke-Command -ComputerName $computerName -FilePath $scriptLocalPath
			if($output -eq 0)
			{
				Write-Verbose "SUCCESS" -Verbose
			}
			else
			{
				$output
				$failed++
				$serversFailed += "$computerName "
			}
			Write-Host ""
			Start-Sleep -s 1
		}
		Write-Host "----------------------"
		if ($failed -gt 0)
		{
			Write-Warning "FAILED for $failed host(s)"
			Write-Warning "$serversFailed"
			return 1
		}
		else
		{	
			Write-Verbose "SUCCESS for all hosts" -Verbose
			return 0
		}
	}
}
elseif ($PSCmdlet.ParameterSetName -eq "ComputerName")
{
	Write-Verbose -Message "ComputerName: $computerName" -Verbose
	Write-Verbose -Message "Context: $context" -Verbose

	# Trim whitespace
	$computerName = $computerName.Trim()

	# Invoke script for the specified computer name
	if ($PSCmdlet.ShouldProcess($computerName, "Invoke script for this host"))
	{
		if($computerName.Count -gt 1)
		{
			Write-Warning -Message "Too many data in ComputerName parameter, should contain only one reference!"
			return 1
		}
		if($computerName.Count -eq 1)
		{
			# Invoke the script on given Computer Name
			$output=Invoke-Command -ComputerName $computerName -FilePath $scriptLocalPath
			Write-Host "----------------------"
			if($output -eq 0)
			{
				Write-Verbose "SUCCESS" -Verbose
				return 0
			}
			else
			{
				Write-Warning "FAIL"
				return 1
			}
		}
	}
}
else
{
	Write-Verbose -Message "ComputerName: localhost"
	# Invoke configuration review for the specified computer name
	$computerName = $env:COMPUTERNAME
	
	if ($PSCmdlet.ShouldProcess("Localhost ($computerName)", "Invoke script for localhost"))
	{
		Write-Verbose -Message "Invoking script for localhost $computerName" -Verbose
		# Invoke the script on localhost
		$output=Invoke-Expression "& `"$scriptLocalPath`""
		Write-Host "----------------------"
		if($output -eq 0)
		{
			Write-Verbose "SUCCESS" -Verbose
			return 0
		}
		else
		{
			Write-Warning "FAIL"
			return 1
		}
	}
}

## ----End
