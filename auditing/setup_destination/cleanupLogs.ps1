#Get Current month and year
$month = (Get-Date).Month
$year = (Get-Date).Year

# Set the root directory to search for files
$rootDirectory = "$PSScriptRoot/logs"

# Set the age threshold for deleting files (3 months)
$ageThreshold = (Get-Date).AddMonths(-3)

# Get all files in the directory that are older than the age threshold
$oldFiles = Get-ChildItem $rootDirectory -File | Where-Object { $_.LastWriteTime -lt $ageThreshold }


Add-Content -Path "$PSScriptRoot/logs/$year-$month.cleanupLogs.log" -Value $(Get-Date)
Add-Content -Path "$PSScriptRoot/logs/$year-$month.cleanupLogs.log" -Value $rootDirectory

# Iterate through each old file
foreach ($oldFile in $oldFiles)
  {
      # Delete the old file
      Remove-Item $rootDirectory\$oldFile -Force

      # Log the file deletion to the log file
      Add-Content -Path "$PSScriptRoot/logs/$year-$month.cleanupLogs.log" -Value "Deleted file $oldFile"
  }

Add-Content -Path "$PSScriptRoot/logs/$year-$month.cleanupLogs.log" -Value "---"
