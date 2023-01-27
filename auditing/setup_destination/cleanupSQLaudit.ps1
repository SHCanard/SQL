#Get Current month and year
$month = (Get-Date).Month
$year = (Get-Date).Year

# Set the root directory to search for files
$rootDirectory = "D:\OUT"

# Set the age threshold for deleting files (3 months)
$ageThreshold = (Get-Date).AddMonths(-3)

# Get all files in the directory that are older than the age threshold
$oldFiles = Get-ChildItem $rootDirectory -File | Where-Object { $_.LastWriteTime -lt $ageThreshold }


Add-Content -Path "$PSScriptRoot/logs/$year-$month.cleanupSQLaudit.log" -Value $(Get-Date)
Add-Content -Path "$PSScriptRoot/logs/$year-$month.cleanupSQLaudit.log" -Value $rootDirectory

# Iterate through each subdirectory
foreach ($subDirectory in $subDirectories)
{
    # Get all files in the subdirectory that are older than the age threshold
    $oldFiles = Get-ChildItem $subDirectory.FullName -File | Where-Object { $_.LastWriteTime -lt $ageThreshold }

    # Iterate through each old file
    foreach ($oldFile in $oldFiles)
    {
        # Delete the old file
        Remove-Item $oldFile.FullName -Force

          # Log the file deletion to the log file
        Add-Content -Path "$PSScriptRoot/logs/$year-$month.cleanupSQLaudit.log" -Value "Deleted file $oldFile.FullName"
    }
}

Add-Content -Path "$PSScriptRoot/logs/$year-$month.cleanupSQLaudit.log" -Value "---"
