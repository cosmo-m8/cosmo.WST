#--------------------SCRIPT EXECUTION--------------------
#--------CHOCOLATEY CHECK--------
Write-Host "Checking Choco..."

if (Test-Path C:\ProgramData\chocolatey\choco.exe){
    'Choco Already Installed'
    $ResultText.text = "`r`n" + "Chocolatey is Installed."
    $installPN.Enabled = $True
    $choco.Enabled = $false
}  
else{
    
	Write-Host "Choco not found"
    $ResultText.text = "`r`n" + "Chocolatey not found. For Installs, install Chocolatey first."

}

#--------SHOW GUI--------
[void]$Form.ShowDialog()

Start-Sleep -Seconds 1

[void]$Form.Focus()