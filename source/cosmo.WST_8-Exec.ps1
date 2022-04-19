#--------------------SCRIPT EXECUTION--------------------

#--------CHOCOLATEY CHECK--------
Write-Host "Checking Choco..."

if (Test-Path C:\ProgramData\chocolatey\choco.exe){
    Write-Log("Chocolatey Already Installed")

    $installPN.Enabled = $True
    $choco.Enabled = $false
}  
else{
	Write-Log("Chocolatey not found...")
    Write-Log("Please install Chocolatey first!!!")
}

#--------SHOW GUI--------
[void]$Form.ShowDialog()

Start-Sleep -Seconds 3

[void]$Form.Focus()