#--------------------BUTTON CLICK EVENTS--------------------
#--------INSTALL SECTION--------
$choco.Add_Click({
    Write-Log ("`r`n" + "Installing Chocolatey")
    Write-Log ("...Please Wait")
    
    Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

    Write-Log ("Finished Installing Chocolatey")
    Write-Log (" >>> Ready for Next Task")

    $installPN.Enabled      = $True
    $choco.Enabled          = $false
})

$cosmo.Add_Click({
    Install-Software 7zip
    Install-Software vlc
    Install-Software sumatrapdf
    Install-Software libreoffice-fresh
    Install-Software googlechrome
    Install-Software googledrive
    Install-Software gimp
    Install-Software vscode
    Install-Software notepadplusplus
    Install-Software microsoft-windows-terminal
})

$essentials.Add_Click({
    Install-Software 7zip
    Install-Software vlc
    Install-Software sumatrapdf
    Install-Software libreoffice-still
    Install-Software googlechrome
})

$doctools.Add_Click({
    Install-Software sumatrapdf
    Install-Software libreoffice-still
    Install-Software notepadplusplus
})

$mediatools.Add_Click({
    Install-Software vlc
    Install-Software gimp
    Install-Software audacity
    Install-Software audacity-lame
    Install-Software audacity-ffmpeg
    Install-Software filezilla
})

$consumption.Add_Click({
    Install-Software steam-client
    Install-Software itunes
})

$devtools.Add_Click({
    Install-Software gimp
    Install-Software audacity
    Install-Software audacity-lame
    Install-Software audacity-ffmpeg
    Install-Software vscode
    Install-Software notepadplusplus
    Install-Software microsoft-windows-terminal
    Install-Software filezilla
    Install-Software git
})

$deps.Add_Click({
    Install-Software javaruntime
    Install-Software nvm
    Install-Software git
})

$cosmo2.Add_Click({
    Install-Software parsec
    Install-Software git
    Install-Software gitkraken
    Install-Software nvm
})

$openAppForm.Add_Click({
    [void]$appForm.ShowDialog()
})

$updChocos.Add_Click({
    Install-Updates
})

#--------TWEAKS SECTION--------
$restorePt.Add_Click({
    Add-RestorePoint
})

$cosmoCfg.Add_Click({
    Set-cosmoCfg $True
})

$UcosmoCfg.Add_Click({
    Set-cosmoCfg $false
})

$essenCfg.Add_Click({
    Set-EssentialsCfg $True
    "• System Restore Point`r`n• Quality of Life`r`n• Disable Telemetry`r`n• Disable Location Tracking`r`n• Disable Utilities`r`n• Enable UTC-Time"
})

$UessenCfg.Add_Click({
    Set-EssentialsCfg $false
})

$QoL.Add_Click({
    Set-QoLCfg $True
})

$UQoL.Add_Click({
    Set-QoLCfg $false
})

$darkMode.Add_Click({
    Set-Darkmode $True
})

$UdarkMode.Add_Click({
    Set-Darkmode $false
})

$perfVfx.Add_Click({
    Set-PerfVFX $True
})

$UperfVfx.Add_Click({
    Set-PerfVFX $false
})

$telem.Add_Click({
    Set-TeleCfg $True
})

$Utelem.Add_Click({
    Set-TeleCfg $false
})

$loctrack.Add_Click({
    Set-LocCfg $True
})

$Uloctrack.Add_Click({
    Set-LocCfg $false
})

$oneDrive.Add_Click({
    Set-OneDriveCfg $True
})

$UoneDrive.Add_Click({
    Set-OneDriveCfg $false
})

$discortana.Add_Click({
    Set-CortanaCfg $True
})

$Udiscortana.Add_Click({
    Set-CortanaCfg $false
})

$actionc.Add_Click({
    Set-ActionCfg $True
})

$Uactionc.Add_Click({
    Set-ActionCfg $false
})

$bgApps.Add_Click({
    Set-BGAppsCfg $True
})

$UbgApps.Add_Click({
    Set-BGAppsCfg $false
})

$utils.Add_Click({
    Set-UtilitiesCfg $True
})

$Uutils.Add_Click({
    Set-UtilitiesCfg $false
})

$clipbH.Add_Click({
    Set-ClipCfg $True
})

$UclipbH.Add_Click({
    Set-ClipCfg $false
})

$UTCTime.Add_Click({
    Set-UTCTime $True
})

$UUTCTime.Add_Click({
    Set-UTCTime $false
})

#--------FIXES/TOOLS SECTION--------
$phoneFix.Add_Click({
    Start-PhoneFix
})

$updReset.Add_Click({
    Start-WinUpdReset
})

$power.Add_Click({
    Start-PowerReset
})

$powerCfg.Add_Click({
    Start-PowerConfig
})

$hyperV.Add_Click({
    Start-HyperV
})

$nfs.Add_Click({
    Start-NFS
})

$dlWST.Add_Click({
    $Url = "https://raw.githubusercontent.com/cosmo-m8/cosmo.WST/main/dist/cosmo.WST.ps1"
    $DownloadZipFile = "$($env:USERPROFILE)\Desktop\cosmo.WST.ps1"
    $ExtractPath = "$($env:USERPROFILE)\Desktop\"
    Invoke-WebRequest -Uri $Url -OutFile $DownloadZipFile
    Start-Process $ExtractPath

    Write-Log ("Downloaded and Extracted cosmo.WST to the Desktop")
})

$dlSDI.Add_Click({
    $Url = "https://drive.google.com/uc?export=download&id=1-9eI1SVl3miSbHMU9dNlk5uyivR6saMK"
    $DownloadZipFile = "$($env:USERPROFILE)\Desktop\SDI_R2201_i220228.zip"
    $ExtractPath = "$($env:USERPROFILE)\Desktop\"
    Invoke-WebRequest -Uri $Url -OutFile $DownloadZipFile
    $ExtractShell = New-Object -ComObject Shell.Application 
    $ExtractFiles = $ExtractShell.Namespace($DownloadZipFile).Items() 
    $ExtractShell.NameSpace($ExtractPath).CopyHere($ExtractFiles) 
    Start-Process $ExtractPath

    Write-Log ("Downloaded and Extracted SDI to the Desktop")
})

$dlSysIntMicro.Add_Click({
    $Url = "https://drive.google.com/uc?export=download&id=10M3nyJm0ZVDE6dOOwkrFzbrlFuhEulS_"
    $DownloadZipFile = "$($env:USERPROFILE)\Desktop\SysIntMicro.zip"
    $ExtractPath = "$($env:USERPROFILE)\Desktop\"
    Invoke-WebRequest -Uri $Url -OutFile $DownloadZipFile
    $ExtractShell = New-Object -ComObject Shell.Application 
    $ExtractFiles = $ExtractShell.Namespace($DownloadZipFile).Items() 
    $ExtractShell.NameSpace($ExtractPath).CopyHere($ExtractFiles) 
    Start-Process $ExtractPath

    Write-Log ("Downloaded and Extracted SysInternals Lite to the Desktop")
})

$dlSysIntMini.Add_Click({
    $Url = "https://drive.google.com/uc?export=download&id=10a4FZhgRSXl_21VYp4b9kl_2CfyNyAsz"
    $DownloadZipFile = "$($env:USERPROFILE)\Desktop\SysIntMini.zip"
    $ExtractPath = "$($env:USERPROFILE)\Desktop\"
    Invoke-WebRequest -Uri $Url -OutFile $DownloadZipFile
    $ExtractShell = New-Object -ComObject Shell.Application 
    $ExtractFiles = $ExtractShell.Namespace($DownloadZipFile).Items() 
    $ExtractShell.NameSpace($ExtractPath).CopyHere($ExtractFiles) 
    Start-Process $ExtractPath

    Write-Log ("Downloaded and Extracted SysInternals Mini to the Desktop")
})

$dlSysInt.Add_Click({
    $Url = "https://drive.google.com/uc?export=download&id=10Ukq6yAnpHOFUe0GRPBmRtF8x-fOfmKZ"
    $DownloadZipFile = "$($env:USERPROFILE)\Desktop\SysIntSuite.zip"
    $ExtractPath = "$($env:USERPROFILE)\Desktop\"
    Invoke-WebRequest -Uri $Url -OutFile $DownloadZipFile
    $ExtractShell = New-Object -ComObject Shell.Application 
    $ExtractFiles = $ExtractShell.Namespace($DownloadZipFile).Items() 
    $ExtractShell.NameSpace($ExtractPath).CopyHere($ExtractFiles) 
    Start-Process $ExtractPath

    Write-Log ("Downloaded and Extracted SysInternals to the Desktop")
})

#--------WIN UPDATE SECTION--------
$updDef.Add_Click({
    Set-WinUpdDefault
})

$updSec.Add_Click({
    Set-WinUpdSecurity
})

$updEn.Add_Click({
    Set-WinUpdServices $True
})

$updDis.Add_Click({
    Set-WinUpdServices $false
})

#---------------------
$verLB.Add_Click({
    Write-Log("HAHAHAH")
})

$rebPC.Add_Click({
    Show-RebootDialog
})