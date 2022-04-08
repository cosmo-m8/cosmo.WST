#--------------------BUTTON CLICK EVENTS--------------------
$choco.Add_Click({
    Write-Log ("`r`n" + "Installing Chocolatey")
    Write-Log ("...Please Wait")
    
    #Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

    Write-Log ("Finished Installing Chocolatey")
    Write-Log (" >>> Ready for Next Task")

    $installPN.Enabled      = $True
    $choco.Enabled          = $false
})

$cosmo.Add_Click({
    Install-Software Test
})

$openAppForm.Add_Click({
    [void]$appForm.ShowDialog()
})

$restorePt.Add_Click({
    Add-RestorePoint
})

$tmpBT1.Add_Click({
    Set-Telemetry on
})