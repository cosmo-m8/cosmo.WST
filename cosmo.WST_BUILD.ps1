# DOT SOURCING VER Variable
# File Containing $ver
. "$PSScriptRoot\source\cosmo.WST_1-Init.ps1"

# The path (relative or absolute) of the output file
# When using $ver variable *VER* will be replaced with it
[string]$outputRaw = ".\dist\cosmo.WST_*VER*.ps1"
    
# The path (relative or absolute) of the source file or files
[string]$source = ".\source\"
    
# The filter to be applied to the source when retrieving files 
[string]$filter = "cosmo.WST_*"

# The path (relative or absolute) of the release file
[string]$finalFile = ".\dist\cosmo.WST.ps1"
    
# separator symbol between each file which includes the file name
[string]$seps = "#"

[string]$output = $outputRaw.Replace('*VER*',$ver)

# ---------- EXEC ----------
Write-Host "`n + Setting up output file:" $output "`n"
New-Item -ItemType file $output -force | Out-Null

$files = Get-ChildItem $source -filter $filter

# Exclude folder objects
$files = $files | Where-Object { $_.PSIsContainer -ne $true }
# Exclude the output file
$files = $files | Where-Object { $_.Name -ne $output }
       
# Add the content of each file to the output file
foreach ($fileInfo in $files) {
    if($fileInfo) {
        Write-Host " +"$fileInfo.FullName
        
        # Add a file path separator to the file
        Add-Content $output ($seps + " ------------------------- " + [string]$fileInfo + " ------------------------- " + $seps + "`n")
        
        # Add the file content to the output file
        Add-Content $output (Get-Content $fileInfo.FullName) 
        
        # Add a line break to the end
        Add-Content $output "`n"
    }
}

Write-Host "`nCreating release file"
[System.IO.File]::Copy($output, $finalFile, $True)
Write-Host "`n" $finalFile "created"
Write-Host "`n" 