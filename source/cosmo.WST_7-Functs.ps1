#--------------------FUNCTIONS--------------------

#--------LOGGER FX--------
function Write-Log{
    $LogMsg = $args[0]
    Write-Host ("`r`n"+$LogMsg)
    $ResultText.AppendText("`r`n"+$LogMsg)
}

#--------INSTALL FXs--------
function Use-Choco{
    $doChoco = $args
    
    $installPN.Enabled = $false
    $tweaksPN.Enabled = $false
    $fixesPN.Enabled = $false
#    $updatesPN.Enabled = $false

    if ($args[1] -eq "parsec"){
        $chocoblock = {
            choco install parsec --params='/Shared' --force -y | Out-Host
        }
    }
    else{
        $chocoblock = {
            choco $args -y | Out-Host
        }
    }

    Start-Job -ScriptBlock $chocoblock -ArgumentList $doChoco -Name "bgchocojob"

    do {
            [System.Windows.Forms.Application]::DoEvents()
            Start-Sleep -Milliseconds 200
            Receive-Job -Name "bgchocojob"
            }
    while ((Get-Job -Name "bgchocojob").State -ne 'Completed')

    $installPN.Enabled = $True
    $tweaksPN.Enabled = $True
    $fixesPN.Enabled = $True
#    $updatesPN.Enabled = $True

}

function Install-Software{
    $AppName = $args
    
    Write-Log ("`r`n" + "Installing " + $AppName)
    Write-Log ("...Please Wait")
    Use-Choco install $AppName
    Write-Log ("Finished Installing " + $AppName)
    Write-Log (" >>> Ready for Next Task")
    #>
}

function Install-Updates{
    Write-Log ("`r`n" + "Installing Updates")
    Write-Log ("...Please Wait")
    Use-Choco upgrade all
    Write-Log ("Finished Installing Updates")
    Write-Log (" >>> Ready for Next Task")
}

#--------RESTORE POINT FX--------
function Add-RestorePoint{
    Write-Log ("`r`n" + "Creating Restore Point incase something bad happens")
    
    Enable-ComputerRestore -Drive "C:\"
    Checkpoint-Computer -Description "RestorePoint1" -RestorePointType "MODIFY_SETTINGS"
}

#--------TWEAKS FXs--------
function Set-cosmoCfg{
    $setTo = $args[0]

    if ($setTo -eq $True){
        Add-RestorePoint

        Write-Log ("`r`n" + "Installing cosmo's Tweaks... Please Wait")

        Set-QoLCfg $True
        Set-Darkmode $True
        Set-TeleCfg $True
        Set-LocCfg $True
        Set-OneDriveCfg $True
        Set-UtilitiesCfg $True
        Set-UTCTime $True

        Write-Log ("`r`n" + "cosmo's Tweaks Completed - Please Reboot!")
        Write-Log (" >>> Ready for Next Task")
    }
    else{
        Write-Log ("`r`n" + "Uninstalling cosmo's Tweaks... Please Wait")

        Set-QoLCfg $false
        Set-Darkmode $false
        Set-TeleCfg $false
        Set-LocCfg $false
        Set-OneDriveCfg $false
        Set-UtilitiesCfg $false
        Set-UTCTime $false

        Write-Log ("`r`n" + "cosmo's Tweaks Undo Completed - Please Reboot!")
        Write-Log (" >>> Ready for Next Task")
    }
}

function Set-EssentialsCfg{
    $setTo = $args[0]

    if ($setTo -eq $True){
        Add-RestorePoint

        Write-Log ("`r`n" + "Installing Essential Tweaks... Please Wait")
        
        Set-QoLCfg $True
        Set-TeleCfg $True
        Set-LocCfg $True
        Set-UtilitiesCfg $True
        Set-UTCTime $True

        Write-Log ("`r`n" + "Essential Tweaks Completed - Please Reboot!")
        Write-Log (" >>> Ready for Next Task")
    }
    else{
        Write-Log ("`r`n" + "Uninstalling Essential Tweaks... Please Wait")

        Set-QoLCfg $false
        Set-TeleCfg $false
        Set-LocCfg $false
        Set-UtilitiesCfg $false
        Set-UTCTime $false

        Write-Log ("`r`n" + "Essential Undo Completed - Please Reboot!")
        Write-Log (" >>> Ready for Next Task")
    }
}

function Set-QoLCfg{
    $setTo = $args[0]

    if ($setTo -eq $True){
        Write-Log ("`r`n" + "Showing task manager details...")
        $taskmgr = Start-Process -WindowStyle Hidden -FilePath taskmgr.exe -PassThru
        Do {
            Start-Sleep -Milliseconds 100
            $preferences = Get-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\TaskManager" -Name "Preferences" -ErrorAction SilentlyContinue
        } Until ($preferences)
        Stop-Process $taskmgr
        $preferences.Preferences[28] = 0
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\TaskManager" -Name "Preferences" -Type Binary -Value $preferences.Preferences

        Write-Log ("`r`n" + "Showing file operations details...")
        If (!(Test-Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\OperationStatusManager")) {
            New-Item -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\OperationStatusManager" | Out-Null
        }
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\OperationStatusManager" -Name "EnthusiastMode" -Type DWord -Value 1

        Write-Log ("`r`n" + "Hiding People icon...")
        If (!(Test-Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People")) {
            New-Item -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People" | Out-Null
        }
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People" -Name "PeopleBand" -Type DWord -Value 0

        Write-Log ("`r`n" + "Changing default Explorer view to This PC...")
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "LaunchTo" -Type DWord -Value 1

        Write-Log ("`r`n" + "Hiding 3D Objects icon from This PC...")
        Remove-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}" -Recurse -ErrorAction SilentlyContinue
        
        # Network Tweaks
    	Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" -Name "IRPStackSize" -Type DWord -Value 20

        # Group svchost.exe processes
        $ram = (Get-CimInstance -ClassName Win32_PhysicalMemory | Measure-Object -Property Capacity -Sum).Sum / 1kb
        Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control" -Name "SvcHostSplitThresholdInKB" -Type DWord -Value $ram -Force

        Write-Log ("`r`n" + "Disable News and Interests")
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Policies\Microsoft\Windows\Windows Feeds" -Name "EnableFeeds" -Type DWord -Value 0

        # Remove "News and Interest" from taskbar
        Set-ItemProperty -Path  "HKCU:\Software\Microsoft\Windows\CurrentVersion\Feeds" -Name "ShellFeedsTaskbarViewMode" -Type DWord -Value 2

        # remove "Meet Now" button from taskbar
        If (!(Test-Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer")) {
            New-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" -Force | Out-Null
        }

        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" -Name "HideSCAMeetNow" -Type DWord -Value 1

        Write-Log ("`r`n" + "Showing known file extensions...")
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "HideFileExt" -Type DWord -Value 0
    }
    else{
        Write-Log ("`r`n" + "Hiding file operations details...")
        If (!(Test-Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\OperationStatusManager")) {
            Remove-Item -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\OperationStatusManager" -Recurse -ErrorAction SilentlyContinue
        }
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\OperationStatusManager" -Name "EnthusiastMode" -Type DWord -Value 0

        Write-Log ("`r`n" + "Changing default Explorer view to Quick Access...")
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "LaunchTo" -Type DWord -Value 1

        Write-Log ("`r`n" + "Hiding known file extensions")
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "HideFileExt" -Type DWord -Value 1

        Write-Log (" >>> Ready for Next Task")
    }
}

function Set-Darkmode{
    $setTo = $args[0]

    if ($setTo -eq $True){
        Write-Log ("`r`n" + "Enabling Dark Mode")
        Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize -Name AppsUseLightTheme -Value 0

        Write-Log ("Enabled Dark Mode")
        Write-Log (" >>> Ready for Next Task")
    }
    else{
        Write-Log ("`r`n" + "Switching Back to Light Mode")
        Remove-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize -Name AppsUseLightTheme

        Write-Log ("Switched Back to Light Mode")
        Write-Log (" >>> Ready for Next Task")
    }
}

function Set-PerfVFX{
    $setTo = $args[0]

    if ($setTo -eq $True){
        Write-Log ("`r`n" + "Adjusting visual effects for performance...")
        Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "DragFullWindows" -Type String -Value 0
        Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "MenuShowDelay" -Type String -Value 200
        Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "UserPreferencesMask" -Type Binary -Value ([byte[]](144,18,3,128,16,0,0,0))
        Set-ItemProperty -Path "HKCU:\Control Panel\Desktop\WindowMetrics" -Name "MinAnimate" -Type String -Value 0
        Set-ItemProperty -Path "HKCU:\Control Panel\Keyboard" -Name "KeyboardDelay" -Type DWord -Value 0
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ListviewAlphaSelect" -Type DWord -Value 0
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ListviewShadow" -Type DWord -Value 0
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "TaskbarAnimations" -Type DWord -Value 0
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" -Name "VisualFXSetting" -Type DWord -Value 3
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\DWM" -Name "EnableAeroPeek" -Type DWord -Value 0
        
        Write-Log ("Adjusted visual effects for performance")
        Write-Log (" >>> Ready for Next Task")
    }
    else{
        Write-Log ("`r`n" + "Adjusting visual effects for appearance...")
    	Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "DragFullWindows" -Type String -Value 1
    	Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "MenuShowDelay" -Type String -Value 400
    	Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "UserPreferencesMask" -Type Binary -Value ([byte[]](158,30,7,128,18,0,0,0))
    	Set-ItemProperty -Path "HKCU:\Control Panel\Desktop\WindowMetrics" -Name "MinAnimate" -Type String -Value 1
    	Set-ItemProperty -Path "HKCU:\Control Panel\Keyboard" -Name "KeyboardDelay" -Type DWord -Value 1
    	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ListviewAlphaSelect" -Type DWord -Value 1
    	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ListviewShadow" -Type DWord -Value 1
    	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "TaskbarAnimations" -Type DWord -Value 1
    	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" -Name "VisualFXSetting" -Type DWord -Value 3
    	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\DWM" -Name "EnableAeroPeek" -Type DWord -Value 1
        
        Write-Log ("Visual effects are set for appearance (Defaults)")
        Write-Log (" >>> Ready for Next Task")
    }
}

function Set-TeleCfg{
    $setTo = $args[0]

    if ($setTo -eq $True){
        Write-Log ("`r`n" + "Disabling Telemetry...")
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" -Name "AllowTelemetry" -Type DWord -Value 0
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection" -Name "AllowTelemetry" -Type DWord -Value 0
        Disable-ScheduledTask -TaskName "Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser" | Out-Null
        Disable-ScheduledTask -TaskName "Microsoft\Windows\Application Experience\ProgramDataUpdater" | Out-Null
        Disable-ScheduledTask -TaskName "Microsoft\Windows\Autochk\Proxy" | Out-Null
        Disable-ScheduledTask -TaskName "Microsoft\Windows\Customer Experience Improvement Program\Consolidator" | Out-Null
        Disable-ScheduledTask -TaskName "Microsoft\Windows\Customer Experience Improvement Program\UsbCeip" | Out-Null
        Disable-ScheduledTask -TaskName "Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticDataCollector" | Out-Null
        
        Write-Log ("`r`n" + "Disabling Wi-Fi Sense...")
        If (!(Test-Path "HKLM:\Software\Microsoft\PolicyManager\default\WiFi\AllowWiFiHotSpotReporting")) {
            New-Item -Path "HKLM:\Software\Microsoft\PolicyManager\default\WiFi\AllowWiFiHotSpotReporting" -Force | Out-Null
        }
        Set-ItemProperty -Path "HKLM:\Software\Microsoft\PolicyManager\default\WiFi\AllowWiFiHotSpotReporting" -Name "Value" -Type DWord -Value 0
        Set-ItemProperty -Path "HKLM:\Software\Microsoft\PolicyManager\default\WiFi\AllowAutoConnectToWiFiSenseHotspots" -Name "Value" -Type DWord -Value 0

        Write-Log ("`r`n" + "Disabling Application suggestions...")
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "ContentDeliveryAllowed" -Type DWord -Value 0
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "OemPreInstalledAppsEnabled" -Type DWord -Value 0
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "PreInstalledAppsEnabled" -Type DWord -Value 0
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "PreInstalledAppsEverEnabled" -Type DWord -Value 0
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SilentInstalledAppsEnabled" -Type DWord -Value 0
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-338387Enabled" -Type DWord -Value 0
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-338388Enabled" -Type DWord -Value 0
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-338389Enabled" -Type DWord -Value 0
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-353698Enabled" -Type DWord -Value 0
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SystemPaneSuggestionsEnabled" -Type DWord -Value 0
        If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent")) {
            New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent" -Force | Out-Null
        }
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent" -Name "DisableWindowsConsumerFeatures" -Type DWord -Value 1

        Write-Log ("`r`n" + "Disabling Activity History...")
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" -Name "EnableActivityFeed" -Type DWord -Value 0
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" -Name "PublishUserActivities" -Type DWord -Value 0
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" -Name "UploadUserActivities" -Type DWord -Value 0

        Write-Log ("`r`n" + "Disabling Feedback...")
        If (!(Test-Path "HKCU:\SOFTWARE\Microsoft\Siuf\Rules")) {
            New-Item -Path "HKCU:\SOFTWARE\Microsoft\Siuf\Rules" -Force | Out-Null
        }
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Siuf\Rules" -Name "NumberOfSIUFInPeriod" -Type DWord -Value 0
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection" -Name "DoNotShowFeedbackNotifications" -Type DWord -Value 1
        Disable-ScheduledTask -TaskName "Microsoft\Windows\Feedback\Siuf\DmClient" -ErrorAction SilentlyContinue | Out-Null
        Disable-ScheduledTask -TaskName "Microsoft\Windows\Feedback\Siuf\DmClientOnScenarioDownload" -ErrorAction SilentlyContinue | Out-Null

        Write-Log ("`r`n" + "Disabling Tailored Experiences...")
        If (!(Test-Path "HKCU:\SOFTWARE\Policies\Microsoft\Windows\CloudContent")) {
            New-Item -Path "HKCU:\SOFTWARE\Policies\Microsoft\Windows\CloudContent" -Force | Out-Null
        }
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Policies\Microsoft\Windows\CloudContent" -Name "DisableTailoredExperiencesWithDiagnosticData" -Type DWord -Value 1

        Write-Log ("`r`n" + "Disabling Advertising ID...")
        If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AdvertisingInfo")) {
            New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AdvertisingInfo" | Out-Null
        }
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AdvertisingInfo" -Name "DisabledByGroupPolicy" -Type DWord -Value 1
    
        Write-Log ("`r`n" + "Disabling Error reporting...")
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\Windows Error Reporting" -Name "Disabled" -Type DWord -Value 1
        Disable-ScheduledTask -TaskName "Microsoft\Windows\Windows Error Reporting\QueueReporting" | Out-Null

        Write-Log ("`r`n" + "Restricting Windows Update P2P only to local network...")
        If (!(Test-Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Config")) {
            New-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Config" | Out-Null
        }
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Config" -Name "DODownloadMode" -Type DWord -Value 1
    
        Write-Log ("`r`n" + "Stopping and disabling Diagnostics Tracking Service...")
        Stop-Service "DiagTrack" -WarningAction SilentlyContinue
        Set-Service "DiagTrack" -StartupType Disabled
    
        Write-Log ("`r`n" + "Stopping and disabling WAP Push Service...")
        Stop-Service "dmwappushservice" -WarningAction SilentlyContinue
        Set-Service "dmwappushservice" -StartupType Disabled

        Write-Log ("`r`n" + "Removing AutoLogger file and restricting directory...")
        $autoLoggerDir = "$env:PROGRAMDATA\Microsoft\Diagnosis\ETLLogs\AutoLogger"
        If (Test-Path "$autoLoggerDir\AutoLogger-Diagtrack-Listener.etl") {
            Remove-Item "$autoLoggerDir\AutoLogger-Diagtrack-Listener.etl"
        }
        icacls $autoLoggerDir /deny SYSTEM:`(OI`)`(CI`)F | Out-Null

        Write-Log (" >>> Ready for Next Task")
    }
    else{
        Write-Log ("`r`n" + "Enabling Telemetry...")
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" -Name "AllowTelemetry" -Type DWord -Value 1
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection" -Name "AllowTelemetry" -Type DWord -Value 1
        
        Write-Log ("`r`n" + "Enabling Wi-Fi Sense")
        Set-ItemProperty -Path "HKLM:\Software\Microsoft\PolicyManager\default\WiFi\AllowWiFiHotSpotReporting" -Name "Value" -Type DWord -Value 1
        Set-ItemProperty -Path "HKLM:\Software\Microsoft\PolicyManager\default\WiFi\AllowAutoConnectToWiFiSenseHotspots" -Name "Value" -Type DWord -Value 1
        
        Write-Log ("`r`n" + "Enabling Application suggestions...")
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "ContentDeliveryAllowed" -Type DWord -Value 1
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "OemPreInstalledAppsEnabled" -Type DWord -Value 1
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "PreInstalledAppsEnabled" -Type DWord -Value 1
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "PreInstalledAppsEverEnabled" -Type DWord -Value 1
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SilentInstalledAppsEnabled" -Type DWord -Value 1
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-338387Enabled" -Type DWord -Value 1
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-338388Enabled" -Type DWord -Value 1
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-338389Enabled" -Type DWord -Value 1
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-353698Enabled" -Type DWord -Value 1
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SystemPaneSuggestionsEnabled" -Type DWord -Value 1
        If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent")) {
            Remove-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent" -Recurse -ErrorAction SilentlyContinue
        }
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent" -Name "DisableWindowsConsumerFeatures" -Type DWord -Value 0
        
        Write-Log ("`r`n" + "Enabling Activity History...")
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" -Name "EnableActivityFeed" -Type DWord -Value 1
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" -Name "PublishUserActivities" -Type DWord -Value 1
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" -Name "UploadUserActivities" -Type DWord -Value 1

        Write-Log ("`r`n" + "Enabling Feedback...")
        If (!(Test-Path "HKCU:\SOFTWARE\Microsoft\Siuf\Rules")) {
            Remove-Item -Path "HKCU:\SOFTWARE\Microsoft\Siuf\Rules" -Recurse -ErrorAction SilentlyContinue
        }
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Siuf\Rules" -Name "NumberOfSIUFInPeriod" -Type DWord -Value 0
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection" -Name "DoNotShowFeedbackNotifications" -Type DWord -Value 0
        
        Write-Log ("`r`n" + "Enabling Tailored Experiences...")
        If (!(Test-Path "HKCU:\SOFTWARE\Policies\Microsoft\Windows\CloudContent")) {
            Remove-Item -Path "HKCU:\SOFTWARE\Policies\Microsoft\Windows\CloudContent" -Recurse -ErrorAction SilentlyContinue
        }
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Policies\Microsoft\Windows\CloudContent" -Name "DisableTailoredExperiencesWithDiagnosticData" -Type DWord -Value 0
        
        Write-Log ("`r`n" + "Disabling Advertising ID...")
        If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AdvertisingInfo")) {
            Remove-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AdvertisingInfo" -Recurse -ErrorAction SilentlyContinue
        }
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AdvertisingInfo" -Name "DisabledByGroupPolicy" -Type DWord -Value 0
        
        Write-Log ("`r`n" + "Allow Error reporting...")
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\Windows Error Reporting" -Name "Disabled" -Type DWord -Value 0

        Write-Log ("`r`n" + "Allowing Diagnostics Tracking Service...")
        Stop-Service "DiagTrack" -WarningAction SilentlyContinue
        Set-Service "DiagTrack" -StartupType Manual
    
        Write-Log ("`r`n" + "Allowing WAP Push Service...")
        Stop-Service "dmwappushservice" -WarningAction SilentlyContinue
        Set-Service "dmwappushservice" -StartupType Manual

        Write-Log ("`r`n" + "Unrestricting AutoLogger directory")
        $autoLoggerDir = "$env:PROGRAMDATA\Microsoft\Diagnosis\ETLLogs\AutoLogger"
        icacls $autoLoggerDir /grant:r SYSTEM:`(OI`)`(CI`)F | Out-Null

        Write-Log ("`r`n" + "Enabling and starting Diagnostics Tracking Service")
        Set-Service "DiagTrack" -StartupType Automatic
        Start-Service "DiagTrack"

        Write-Log ("`r`n" + "Reset Local Group Policies to Stock Defaults")
        # cmd /c secedit /configure /cfg %windir%\inf\defltbase.inf /db defltbase.sdb /verbose
        cmd /c RD /S /Q "%WinDir%\System32\GroupPolicyUsers"
        cmd /c RD /S /Q "%WinDir%\System32\GroupPolicy"
        cmd /c gpupdate /force
        # Considered using Invoke-GPUpdate but requires module most people won't have installed

        Write-Log (" >>> Ready for Next Task")
    }
}

function Set-LocCfg{
    $setTo = $args[0]

    if ($setTo -eq $True){
        Write-Log ("`r`n" + "Disabling Location Tracking...")
        If (!(Test-Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\location")) {
            New-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\location" -Force | Out-Null
        }
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\location" -Name "Value" -Type String -Value "Deny"
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Sensor\Overrides\{BFA794E4-F964-4FDB-90F6-51056BFE4B44}" -Name "SensorPermissionState" -Type DWord -Value 0
        Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\lfsvc\Service\Configuration" -Name "Status" -Type DWord -Value 0

        Write-Log ("`r`n" + "Disabling automatic Maps updates...")
        Set-ItemProperty -Path "HKLM:\SYSTEM\Maps" -Name "AutoUpdateEnabled" -Type DWord -Value 0

        Write-Log (" >>> Ready for Next Task")
    }
    else{
        Write-Log ("`r`n" + "Enable Location Tracking...")
        If (!(Test-Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\location")) {
            Remove-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\location" -Recurse -ErrorAction SilentlyContinue
        }
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\location" -Name "Value" -Type String -Value "Allow"
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Sensor\Overrides\{BFA794E4-F964-4FDB-90F6-51056BFE4B44}" -Name "SensorPermissionState" -Type DWord -Value 1
        Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\lfsvc\Service\Configuration" -Name "Status" -Type DWord -Value 1
        
        Write-Log ("`r`n" + "Enabling automatic Maps updates...")
        Set-ItemProperty -Path "HKLM:\SYSTEM\Maps" -Name "AutoUpdateEnabled" -Type DWord -Value 1

        Write-Log ("`r`n" + "Enabling Location Provider...")
    	Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors" -Name "DisableWindowsLocationProvider" -ErrorAction SilentlyContinue
    
        Write-Log ("`r`n" + "Enabling Location Scripting...")
        Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors" -Name "DisableLocationScripting" -ErrorAction SilentlyContinue
    
        Write-Log ("`r`n" + "Enabling Location...")
    	Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors" -Name "DisableLocation" -ErrorAction SilentlyContinue
    	Remove-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Sensor\Overrides\{BFA794E4-F964-4FDB-90F6-51056BFE4B44}" -Name "SensorPermissionState" -ErrorAction SilentlyContinue
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{BFA794E4-F964-4FDB-90F6-51056BFE4B44}" -Name "Value" -Type String -Value "Allow"
    
        Write-Log ("`r`n" + "Allow access to Location...")
    	Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\location" -Name "Value" -Type String -Value "Allow"
    	Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\lfsvc\Service\Configuration" -Name "Status" -Type DWord -Value "1"
    	Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" -Name "LetAppsAccessLocation" -ErrorAction SilentlyContinue
    	Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" -Name "LetAppsAccessLocation_UserInControlOfTheseApps" -ErrorAction SilentlyContinue
    	Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" -Name "LetAppsAccessLocation_ForceAllowTheseApps" -ErrorAction SilentlyContinue
    	Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" -Name "LetAppsAccessLocation_ForceDenyTheseApps" -ErrorAction SilentlyContinue
    
        Write-Log ("Location Tracking now on... Reboot to check.")
        Write-Log (" >>> Ready for Next Task")
    }
}

function Set-OneDriveCfg{
    $setTo = $args[0]

    if ($setTo -eq $True){
        Write-Log ("`r`n" + "Disabling OneDrive...")
        If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\OneDrive")) {
            New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\OneDrive" | Out-Null
        }
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\OneDrive" -Name "DisableFileSyncNGSC" -Type DWord -Value 1

        Write-Log ("`r`n" + "Uninstalling OneDrive...")
        Stop-Process -Name "OneDrive" -ErrorAction SilentlyContinue
        Start-Sleep -s 2
        $onedrive = "$env:SYSTEMROOT\SysWOW64\OneDriveSetup.exe"
        If (!(Test-Path $onedrive)) {
            $onedrive = "$env:SYSTEMROOT\System32\OneDriveSetup.exe"
        }
        Start-Process $onedrive "/uninstall" -NoNewWindow -Wait
        Start-Sleep -s 2
        Stop-Process -Name "explorer" -ErrorAction SilentlyContinue
        Start-Sleep -s 2
        Remove-Item -Path "$env:USERPROFILE\OneDrive" -Force -Recurse -ErrorAction SilentlyContinue
        Remove-Item -Path "$env:LOCALAPPDATA\Microsoft\OneDrive" -Force -Recurse -ErrorAction SilentlyContinue
        Remove-Item -Path "$env:PROGRAMDATA\Microsoft OneDrive" -Force -Recurse -ErrorAction SilentlyContinue
        Remove-Item -Path "$env:SYSTEMDRIVE\OneDriveTemp" -Force -Recurse -ErrorAction SilentlyContinue
        If (!(Test-Path "HKCR:")) {
            New-PSDrive -Name HKCR -PSProvider Registry -Root HKEY_CLASSES_ROOT | Out-Null
        }
        Remove-Item -Path "HKCR:\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" -Recurse -ErrorAction SilentlyContinue
        Remove-Item -Path "HKCR:\Wow6432Node\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" -Recurse -ErrorAction SilentlyContinue

        Write-Log ("Deleted and Disabled OneDrive")
        Write-Log (" >>> Ready for Next Task")
    }
    else{
        Write-Log ("`r`n" + "Installing Onedrive. Please Wait...")
        Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\OneDrive" -Name "DisableFileSyncNGSC" -ErrorAction SilentlyContinue
        %systemroot%\SysWOW64\OneDriveSetup.exe

        Write-Log ("Finished Reinstalling OneDrive")
        Write-Log (" >>> Ready for Next Task")
    }
}

function Set-CortanaCfg{
    $setTo = $args[0]

    if ($setTo -eq $True){
        Write-Log ("`r`n" + "Disabling Cortana...")
        If (!(Test-Path "HKCU:\SOFTWARE\Microsoft\Personalization\Settings")) {
            New-Item -Path "HKCU:\SOFTWARE\Microsoft\Personalization\Settings" -Force | Out-Null
        }
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Personalization\Settings" -Name "AcceptedPrivacyPolicy" -Type DWord -Value 0
        If (!(Test-Path "HKCU:\SOFTWARE\Microsoft\InputPersonalization")) {
            New-Item -Path "HKCU:\SOFTWARE\Microsoft\InputPersonalization" -Force | Out-Null
        }
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\InputPersonalization" -Name "RestrictImplicitTextCollection" -Type DWord -Value 1
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\InputPersonalization" -Name "RestrictImplicitInkCollection" -Type DWord -Value 1
        If (!(Test-Path "HKCU:\SOFTWARE\Microsoft\InputPersonalization\TrainedDataStore")) {
            New-Item -Path "HKCU:\SOFTWARE\Microsoft\InputPersonalization\TrainedDataStore" -Force | Out-Null
        }
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\InputPersonalization\TrainedDataStore" -Name "HarvestContacts" -Type DWord -Value 0
        If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search")) {
            New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search" -Force | Out-Null
        }
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search" -Name "AllowCortana" -Type DWord -Value 0

        Write-Log ("Disabled Cortana")
        Write-Log (" >>> Ready for Next Task")
    }
    else{
        Write-Log ("`r`n" + "Enabling Cortana...")
    	Remove-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Personalization\Settings" -Name "AcceptedPrivacyPolicy" -ErrorAction SilentlyContinue
    	If (!(Test-Path "HKCU:\SOFTWARE\Microsoft\InputPersonalization\TrainedDataStore")) {
    		New-Item -Path "HKCU:\SOFTWARE\Microsoft\InputPersonalization\TrainedDataStore" -Force | Out-Null
    	}
    	Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\InputPersonalization" -Name "RestrictImplicitTextCollection" -Type DWord -Value 0
    	Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\InputPersonalization" -Name "RestrictImplicitInkCollection" -Type DWord -Value 0
    	Remove-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\InputPersonalization\TrainedDataStore" -Name "HarvestContacts" -ErrorAction SilentlyContinue
    	Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search" -Name "AllowCortana" -ErrorAction SilentlyContinue
    
        Write-Log ("`r`n" + "Restoring Windows Search...")
    	Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" -Name "BingSearchEnabled" -Type DWord -Value "1"
    	Remove-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" -Name "CortanaConsent" -ErrorAction SilentlyContinue
    	Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search" -Name "DisableWebSearch" -ErrorAction SilentlyContinue
    
        Write-Log ("`r`n" + "Restore and Starting Windows Search Service...")
        Set-Service "WSearch" -StartupType Automatic
        Start-Service "WSearch" -WarningAction SilentlyContinue

        Write-Log ("`r`n" + "Restore Windows Search Icon...")
    	Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" -Name "SearchboxTaskbarMode" -Type DWord -Value 1
    
        Write-Log ("Enabled Cortana and Restored Search")
        Write-Log (" >>> Ready for Next Task")
    }
}

function Set-ActionCfg{
    $setTo = $args[0]

    if ($setTo -eq $True){
        Write-Log ("`r`n" + "Disabling Action Center...")
        If (!(Test-Path "HKCU:\SOFTWARE\Policies\Microsoft\Windows\Explorer")) {
            New-Item -Path "HKCU:\SOFTWARE\Policies\Microsoft\Windows\Explorer" | Out-Null
        }
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Policies\Microsoft\Windows\Explorer" -Name "DisableNotificationCenter" -Type DWord -Value 1
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\PushNotifications" -Name "ToastEnabled" -Type DWord -Value 0

        Write-Log ("Disabled Action Center")
        Write-Log (" >>> Ready for Next Task")
    }
    else{
        Write-Log ("`r`n" + "Enabling Action Center...")
    	Remove-ItemProperty -Path "HKCU:\SOFTWARE\Policies\Microsoft\Windows\Explorer" -Name "DisableNotificationCenter" -ErrorAction SilentlyContinue
    	Remove-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\PushNotifications" -Name "ToastEnabled" -ErrorAction SilentlyContinue
    
        Write-Log ("Enabled Action Center")
        Write-Log (" >>> Ready for Next Task")
    }
}

function Set-BGAppsCfg{
    $setTo = $args[0]

    if ($setTo -eq $True){
        Write-Log ("`r`n" + "Disabling Background application access...")
        Get-ChildItem -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications" -Exclude "Microsoft.Windows.Cortana*" | ForEach {
            Set-ItemProperty -Path $_.PsPath -Name "Disabled" -Type DWord -Value 1
            Set-ItemProperty -Path $_.PsPath -Name "DisabledByUser" -Type DWord -Value 1
        }

        Write-Log ("Disabled Background application access")
        Write-Log (" >>> Ready for Next Task")
    }
    else{
        Write-Log ("`r`n" + "Allowing Background Apps...")
    	Get-ChildItem -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications" -Exclude "Microsoft.Windows.Cortana*" | ForEach {
    		Remove-ItemProperty -Path $_.PsPath -Name "Disabled" -ErrorAction SilentlyContinue
    		Remove-ItemProperty -Path $_.PsPath -Name "DisabledByUser" -ErrorAction SilentlyContinue
    	}
    
        Write-Log ("Enabled Background Apps")
        Write-Log (" >>> Ready for Next Task")
    }
}

function Set-UtilitiesCfg{
    $setTo = $args[0]

    if ($setTo -eq $True){
        Write-Log ("`r`n" + "Stopping and disabling Home Groups services...")
        Stop-Service "HomeGroupListener" -WarningAction SilentlyContinue
        Set-Service "HomeGroupListener" -StartupType Disabled
        Stop-Service "HomeGroupProvider" -WarningAction SilentlyContinue
        Set-Service "HomeGroupProvider" -StartupType Disabled

        Write-Log ("`r`n" + "Disabling Remote Assistance...")
        Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Remote Assistance" -Name "fAllowToGetHelp" -Type DWord -Value 0

        Write-Log ("`r`n" + "Disabling Storage Sense...")
        Remove-Item -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\StorageSense\Parameters\StoragePolicy" -Recurse -ErrorAction SilentlyContinue

        Write-Log ("`r`n" + "Stopping and disabling Superfetch service...")
        Stop-Service "SysMain" -WarningAction SilentlyContinue
        Set-Service "SysMain" -StartupType Disabled

        Write-Log ("`r`n" + "Disabling Hibernation...")
        Set-ItemProperty -Path "HKLM:\System\CurrentControlSet\Control\Session Manager\Power" -Name "HibernteEnabled" -Type Dword -Value 0
        If (!(Test-Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FlyoutMenuSettings")) {
            New-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FlyoutMenuSettings" | Out-Null
        }
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FlyoutMenuSettings" -Name "ShowHibernateOption" -Type Dword -Value 0

        Write-Log (" >>> Ready for Next Task")
    }
    else{
        Write-Log ("`r`n" + "Allowing Home Groups services...")
        Stop-Service "HomeGroupListener" -WarningAction SilentlyContinue
        Set-Service "HomeGroupListener" -StartupType Manual
        Stop-Service "HomeGroupProvider" -WarningAction SilentlyContinue
        Set-Service "HomeGroupProvider" -StartupType Manual
        
        Write-Log ("`r`n" + "Enabling Storage Sense...")
        New-Item -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\StorageSense\Parameters\StoragePolicy" | Out-Null
        
        Write-Log ("`r`n" + "Allowing Superfetch service...")
        Stop-Service "SysMain" -WarningAction SilentlyContinue
        Set-Service "SysMain" -StartupType Manual

        Write-Log ("`r`n" + "Enabling Hibernation...")
        Set-ItemProperty -Path "HKLM:\System\CurrentControlSet\Control\Session Manager\Power" -Name "HibernteEnabled" -Type Dword -Value 1
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FlyoutMenuSettings" -Name "ShowHibernateOption" -Type Dword -Value 1
    	Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Personalization" -Name "NoLockScreen" -ErrorAction SilentlyContinue

        Write-Log ("Done - Reverted to Stock Settings")
        Write-Log (" >>> Ready for Next Task")
    }
}

function Set-ClipCfg{
    $setTo = $args[0]

    if ($setTo -eq $True){
        Write-Log ("`r`n" + "Disabling Clipboard History...")

        Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Clipboard" -Name "EnableClipboardHistory" -Type Dword -Value 0
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" -Name "AllowClipboardHistory" -Type Dword -Value 0
        
        Write-Log ("Disabled Clipboard History")
        Write-Log (" >>> Ready for Next Task")
    }
    else{
        Write-Log ("`r`n" + "Restoring Clipboard History...")

    	Remove-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Clipboard" -Name "EnableClipboardHistory" -ErrorAction SilentlyContinue
        Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" -Name "AllowClipboardHistory" -ErrorAction SilentlyContinue
    
        Write-Log ("Enabled Clipboard History")
        Write-Log (" >>> Ready for Next Task")
    }
}

function Set-UTCTime{
    $setTo = $args[0]

    if ($setTo -eq $True){
        Write-Log ("`r`n" + "Setting BIOS time to UTC...")

        Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\TimeZoneInformation" -Name "RealTimeIsUniversal" -Type DWord -Value 1
        
        Write-Log ("Time set to UTC for consistent time in Dual Boot Systems")
        Write-Log (" >>> Ready for Next Task")
    }
    else{
        Write-Log ("`r`n" + "Setting BIOS time to Local Time instead of UTC...")

        Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\TimeZoneInformation" -Name "RealTimeIsUniversal" -Type DWord -Value 0

        Write-Log (" >>> Ready for Next Task")
    }
}

#--------FIXES/TOOLS SECTION--------
function Start-PhoneFix{
    Write-Log ("Reinstalling Your Phone App")
        Add-AppxPackage -DisableDevelopmentMode -Register "$($(Get-AppXPackage -AllUsers "Microsoft.YourPhone").InstallLocation)\AppXManifest.xml"

    Write-Log ("Enable needed data collection for Your Phone...")
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" -Name "EnableMmx" -Type DWord -Value 1
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" -Name "EnableCdp" -Type DWord -Value 1
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Messaging" -Name "AllowMessageSync" -Type DWord -Value 1

    Write-Log ("Allowing Background Apps...")
    	Get-ChildItem -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications" -Exclude "Microsoft.Windows.Cortana*" | ForEach {
    		Remove-ItemProperty -Path $_.PsPath -Name "Disabled" -ErrorAction SilentlyContinue
    		Remove-ItemProperty -Path $_.PsPath -Name "DisabledByUser" -ErrorAction SilentlyContinue
    	}

    Write-Log ("You may need to Reboot and right-click Your Phone app and select repair")
    Write-Log (" >>> Ready for Next Task")
}

function Start-WinUpdReset{
    Write-Log ("1. Stopping Windows Update Services...") 
    Stop-Service -Name BITS 
    Stop-Service -Name wuauserv 
    Stop-Service -Name appidsvc 
    Stop-Service -Name cryptsvc 
    
    Write-Log ("2. Remove QMGR Data file...") 
    Remove-Item "$env:allusersprofile\Application Data\Microsoft\Network\Downloader\qmgr*.dat" -ErrorAction SilentlyContinue 
    
    Write-Log ("3. Renaming the Software Distribution and CatRoot Folder...") 
    Rename-Item $env:systemroot\SoftwareDistribution SoftwareDistribution.bak -ErrorAction SilentlyContinue 
    Rename-Item $env:systemroot\System32\Catroot2 catroot2.bak -ErrorAction SilentlyContinue 
    
    Write-Log ("4. Removing old Windows Update log...") 
    Remove-Item $env:systemroot\WindowsUpdate.log -ErrorAction SilentlyContinue 
    
    Write-Log ("5. Resetting the Windows Update Services to defualt settings...") 
    "sc.exe sdset bits D:(A;;CCLCSWRPWPDTLOCRRC;;;SY)(A;;CCDCLCSWRPWPDTLOCRSDRCWDWO;;;BA)(A;;CCLCSWLOCRRC;;;AU)(A;;CCLCSWRPWPDTLOCRRC;;;PU)" 
    "sc.exe sdset wuauserv D:(A;;CCLCSWRPWPDTLOCRRC;;;SY)(A;;CCDCLCSWRPWPDTLOCRSDRCWDWO;;;BA)(A;;CCLCSWLOCRRC;;;AU)(A;;CCLCSWRPWPDTLOCRRC;;;PU)" 
    
    Set-Location $env:systemroot\system32 
    
    Write-Log ("6. Registering some DLLs...") 
    regsvr32.exe /s atl.dll 
    regsvr32.exe /s urlmon.dll 
    regsvr32.exe /s mshtml.dll 
    regsvr32.exe /s shdocvw.dll 
    regsvr32.exe /s browseui.dll 
    regsvr32.exe /s jscript.dll 
    regsvr32.exe /s vbscript.dll 
    regsvr32.exe /s scrrun.dll 
    regsvr32.exe /s msxml.dll 
    regsvr32.exe /s msxml3.dll 
    regsvr32.exe /s msxml6.dll 
    regsvr32.exe /s actxprxy.dll 
    regsvr32.exe /s softpub.dll 
    regsvr32.exe /s wintrust.dll 
    regsvr32.exe /s dssenh.dll 
    regsvr32.exe /s rsaenh.dll 
    regsvr32.exe /s gpkcsp.dll 
    regsvr32.exe /s sccbase.dll 
    regsvr32.exe /s slbcsp.dll 
    regsvr32.exe /s cryptdlg.dll 
    regsvr32.exe /s oleaut32.dll 
    regsvr32.exe /s ole32.dll 
    regsvr32.exe /s shell32.dll 
    regsvr32.exe /s initpki.dll 
    regsvr32.exe /s wuapi.dll 
    regsvr32.exe /s wuaueng.dll 
    regsvr32.exe /s wuaueng1.dll 
    regsvr32.exe /s wucltui.dll 
    regsvr32.exe /s wups.dll 
    regsvr32.exe /s wups2.dll 
    regsvr32.exe /s wuweb.dll 
    regsvr32.exe /s qmgr.dll 
    regsvr32.exe /s qmgrprxy.dll 
    regsvr32.exe /s wucltux.dll 
    regsvr32.exe /s muweb.dll 
    regsvr32.exe /s wuwebv.dll 
    
    Write-Log ("7) Removing WSUS client settings...") 
    REG DELETE "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate" /v AccountDomainSid /f 
    REG DELETE "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate" /v PingID /f 
    REG DELETE "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate" /v SusClientId /f 
    
    Write-Log ("8) Resetting the WinSock...") 
    netsh winsock reset 
    netsh winhttp reset proxy 
        
    Write-Log ("9) Delete all BITS jobs...") 
    Get-BitsTransfer | Remove-BitsTransfer 
    
    Write-Log ("10) Attempting to install the Windows Update Agent...") 
    if($arch -eq 64){ 
        wusa Windows8-RT-KB2937636-x64 /quiet 
    } 
    else{ 
        wusa Windows8-RT-KB2937636-x86 /quiet 
    } 

    Write-Log ("11) Starting Windows Update Services...") 
    Start-Service -Name BITS 
    Start-Service -Name wuauserv 
    Start-Service -Name appidsvc 
    Start-Service -Name cryptsvc 

    Write-Log ("12) Forcing discovery...") 
    wuauclt /resetauthorization /detectnow 

    Write-Log ("Process complete. Please reboot your computer.")
    Write-Log (" >>> Ready for Next Task")
}

function Start-PowerReset{
    powercfg -duplicatescheme a1841308-3541-4fab-bc81-f71556f20b4a
    powercfg -duplicatescheme 381b4222-f694-41f0-9685-ff5bb260df2e
    powercfg -duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61

    Write-Log ("Restored all power plans: Balanced, High Performance, and Power Saver")
    Write-Log (" >>> Ready for Next Task")
}

function Start-PowerConfig{
    cmd /c powercfg.cpl
}

function Start-HyperV{
    Enable-WindowsOptionalFeature -Online -FeatureName "HypervisorPlatform" -All
    Enable-WindowsOptionalFeature -Online -FeatureName "VirtualMachinePlatform" -All
    Enable-WindowsOptionalFeature -Online -FeatureName "Microsoft-Windows-Subsystem-Linux" -All
    Enable-WindowsOptionalFeature -Online -FeatureName "Microsoft-Hyper-V-All" -All
    Enable-WindowsOptionalFeature -Online -FeatureName "Microsoft-Hyper-V" -All
    Enable-WindowsOptionalFeature -Online -FeatureName "Microsoft-Hyper-V-Tools-All" -All
    Enable-WindowsOptionalFeature -Online -FeatureName "Microsoft-Hyper-V-Management-PowerShell" -All
    Enable-WindowsOptionalFeature -Online -FeatureName "Microsoft-Hyper-V-Hypervisor" -All
    Enable-WindowsOptionalFeature -Online -FeatureName "Microsoft-Hyper-V-Services" -All
    Enable-WindowsOptionalFeature -Online -FeatureName "Microsoft-Hyper-V-Management-Clients" -All
    cmd /c bcdedit /set hypervisorschedulertype classic

    Write-Log ("HyperV is now installed and configured. Please Reboot before using.")
    Write-Log (" >>> Ready for Next Task")
}

function Start-NFS{
    Enable-WindowsOptionalFeature -Online -FeatureName "ServicesForNFS-ClientOnly" -All
    Enable-WindowsOptionalFeature -Online -FeatureName "ClientForNFS-Infrastructure" -All
    Enable-WindowsOptionalFeature -Online -FeatureName "NFS-Administration" -All
    nfsadmin client stop
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\ClientForNFS\CurrentVersion\Default" -Name "AnonymousUID" -Type DWord -Value 0
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\ClientForNFS\CurrentVersion\Default" -Name "AnonymousGID" -Type DWord -Value 0
    nfsadmin client start
    nfsadmin client localhost config fileaccess=755 SecFlavors=+sys -krb5 -krb5i

    Write-Log ("NFS is now setup for user based NFS mounts")
    Write-Log (" >>> Ready for Next Task")
}

function Get-ZIPtoDesk{
    $dlURL          = $args[0]
    $dlDEST         = $args[1]
    $dlZIP          = $args[2]

    if ($dlDEST -eq "Desktop"){
        $DesktopPath = [Environment]::GetFolderPath("Desktop")
    }
    else{

    }

    if ($dlZIP -eq $True){

    }
    else{

    }

    $Url            = $dlURL
    $ZipFile        = '$env:USERPROFILE\Desktop\' + $(Split-Path -Path $Url -Leaf) 
    $Destination    = $dlDEST
 
    Invoke-WebRequest -Uri $Url -OutFile $ZipFile

    $ExtractShell = New-Object -ComObject Shell.Application 
    $Files = $ExtractShell.Namespace($ZipFile).Items() 
    $ExtractShell.NameSpace($Destination).CopyHere($Files)

    Write-Log ("Downloaded and Extracted SDI to the Desktop")
    Write-Log (" >>> Ready for Next Task")
}

#--------WIN UPDATE SECTION--------
function Set-WinUpdDefault{
    
}

function Set-WinUpdSecurity{
    
}

function Set-WinUpdServices{
    $setTo = $args[0]

    if ($setTo -eq $True){

    }
    else{

    }
}

function Use-ForceReboot{
    Restart-Computer -Force
}

function Show-RebootDialog{
    $msgBoxInput =  [System.Windows.MessageBox]::Show('For full functionality of cosmo.WST - Tweaks and Fixes the Computer needs to be rebooted after usage.' + "`n`n`n" + 'Would you like to reboot NOW?' + "`n`n",'Reboot required!','YesNo','Asterisk')

        switch  ($msgBoxInput) {
            'Yes' {
                Use-ForceReboot
            }
            'No' {
                #
            }
            'Cancel' {
                #
            }
        }
}


