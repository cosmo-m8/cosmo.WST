##############################################################
        Write-Host "Running O&O Shutup with Recommended Settings"
        $ResultText.text += "`r`n" +"Running O&O Shutup with Recommended Settings"
        Import-Module BitsTransfer
        Start-BitsTransfer -Source "https://raw.githubusercontent.com/ChrisTitusTech/win10script/master/ooshutup10.cfg" -Destination ooshutup10.cfg
        Start-BitsTransfer -Source "https://dl5.oo-software.com/files/ooshutup10/OOSU10.exe" -Destination OOSU10.exe
        ./OOSU10.exe ooshutup10.cfg /quiet

##############################################################
        Write-Host "Enabling F8 boot menu options..."
        bcdedit /set `{current`} bootmenupolicy Legacy | Out-Null

<#
        Write-Host "Hiding Task View button..."
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ShowTaskViewButton" -Type DWord -Value 0


        Write-Host "Hide tray icons..."
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" -Name "EnableAutoTray" -Type DWord -Value 1


        Write-Host "Enabling NumLock after startup..."
        If (!(Test-Path "HKU:")) {
            New-PSDrive -Name HKU -PSProvider Registry -Root HKEY_USERS | Out-Null
        }
        Set-ItemProperty -Path "HKU:\.DEFAULT\Control Panel\Keyboard" -Name "InitialKeyboardIndicators" -Type DWord -Value 2147483650
        Add-Type -AssemblyName System.Windows.Forms
        If (!([System.Windows.Forms.Control]::IsKeyLocked('NumLock'))) {
            $wsh = New-Object -ComObject WScript.Shell
            $wsh.SendKeys('{NUMLOCK}')
        }
#>
##############################################################
        # Service tweaks to Manual 
        $services = @(
        "diagnosticshub.standardcollector.service"     # Microsoft (R) Diagnostics Hub Standard Collector Service
        "DiagTrack"                                    # Diagnostics Tracking Service
        "DPS"
        "dmwappushservice"                             # WAP Push Message Routing Service (see known issues)
        "lfsvc"                                        # Geolocation Service
        "MapsBroker"                                   # Downloaded Maps Manager
        "NetTcpPortSharing"                            # Net.Tcp Port Sharing Service
        "RemoteAccess"                                 # Routing and Remote Access
        "RemoteRegistry"                               # Remote Registry
        "SharedAccess"                                 # Internet Connection Sharing (ICS)
        "TrkWks"                                       # Distributed Link Tracking Client
        #"WbioSrvc"                                     # Windows Biometric Service (required for Fingerprint reader / facial detection)
        #"WlanSvc"                                      # WLAN AutoConfig
        "WMPNetworkSvc"                                # Windows Media Player Network Sharing Service
        #"wscsvc"                                       # Windows Security Center Service
        "WSearch"                                      # Windows Search
        "XblAuthManager"                               # Xbox Live Auth Manager
        "XblGameSave"                                  # Xbox Live Game Save Service
        "XboxNetApiSvc"                                # Xbox Live Networking Service
        "XboxGipSvc"                                   #Disables Xbox Accessory Management Service
        "ndu"                                          # Windows Network Data Usage Monitor
        "WerSvc"                                       #disables windows error reporting
        #"Spooler"                                      #Disables your printer
        "Fax"                                          #Disables fax
        "fhsvc"                                        #Disables fax histroy
        "gupdate"                                      #Disables google update
        "gupdatem"                                     #Disable another google update
        "stisvc"                                       #Disables Windows Image Acquisition (WIA)
        "AJRouter"                                     #Disables (needed for AllJoyn Router Service)
        "MSDTC"                                        # Disables Distributed Transaction Coordinator
        "WpcMonSvc"                                    #Disables Parental Controls
        "PhoneSvc"                                     #Disables Phone Service(Manages the telephony state on the device)
        "PrintNotify"                                  #Disables Windows printer notifications and extentions
        "PcaSvc"                                       #Disables Program Compatibility Assistant Service
        "WPDBusEnum"                                   #Disables Portable Device Enumerator Service
        #"LicenseManager"                               #Disable LicenseManager(Windows store may not work properly)
        "seclogon"                                     #Disables  Secondary Logon(disables other credentials only password will work)
        "SysMain"                                      #Disables sysmain
        "lmhosts"                                      #Disables TCP/IP NetBIOS Helper
        "wisvc"                                        #Disables Windows Insider program(Windows Insider will not work)
        "FontCache"                                    #Disables Windows font cache
        "RetailDemo"                                   #Disables RetailDemo whic is often used when showing your device
        "ALG"                                          # Disables Application Layer Gateway Service(Provides support for 3rd party protocol plug-ins for Internet Connection Sharing)
        #"BFE"                                         #Disables Base Filtering Engine (BFE) (is a service that manages firewall and Internet Protocol security)
        #"BrokerInfrastructure"                         #Disables Windows infrastructure service that controls which background tasks can run on the system.
        "SCardSvr"                                      #Disables Windows smart card
        "EntAppSvc"                                     #Disables enterprise application management.
        "BthAvctpSvc"                                   #Disables AVCTP service (if you use  Bluetooth Audio Device or Wireless Headphones. then don't disable this)
        #"FrameServer"                                   #Disables Windows Camera Frame Server(this allows multiple clients to access video frames from camera devices.)
        "Browser"                                       #Disables computer browser
        "BthAvctpSvc"                                   #AVCTP service (This is Audio Video Control Transport Protocol service.)
        #"BDESVC"                                        #Disables bitlocker
        "iphlpsvc"                                      #Disables ipv6 but most websites don't use ipv6 they use ipv4     
        "edgeupdate"                                    # Disables one of edge update service  
        "MicrosoftEdgeElevationService"                 # Disables one of edge  service 
        "edgeupdatem"                                   # disbales another one of update service (disables edgeupdatem)                          
        "SEMgrSvc"                                      #Disables Payments and NFC/SE Manager (Manages payments and Near Field Communication (NFC) based secure elements)
        #"PNRPsvc"                                      # Disables peer Name Resolution Protocol ( some peer-to-peer and collaborative applications, such as Remote Assistance, may not function, Discord will still work)
        #"p2psvc"                                       # Disbales Peer Name Resolution Protocol(nables multi-party communication using Peer-to-Peer Grouping.  If disabled, some applications, such as HomeGroup, may not function. Discord will still work)
        #"p2pimsvc"                                     # Disables Peer Networking Identity Manager (Peer-to-Peer Grouping services may not function, and some applications, such as HomeGroup and Remote Assistance, may not function correctly.Discord will still work)
        "PerfHost"                                      #Disables  remote users and 64-bit processes to query performance .
        "BcastDVRUserService_48486de"                   #Disables GameDVR and Broadcast   is used for Game Recordings and Live Broadcasts
        "CaptureService_48486de"                        #Disables ptional screen capture functionality for applications that call the Windows.Graphics.Capture API.  
        "cbdhsvc_48486de"                               #Disables   cbdhsvc_48486de (clipboard service it disables)
        #"BluetoothUserService_48486de"                  #disbales BluetoothUserService_48486de (The Bluetooth user service supports proper functionality of Bluetooth features relevant to each user session.)
        "WpnService"                                    #Disables WpnService (Push Notifications may not work )
        #"StorSvc"                                       #Disables StorSvc (usb external hard drive will not be reconised by windows)
        "RtkBtManServ"                                  #Disables Realtek Bluetooth Device Manager Service
        "QWAVE"                                         #Disables Quality Windows Audio Video Experience (audio and video might sound worse)
         #Hp services
        "HPAppHelperCap"
        "HPDiagsCap"
        "HPNetworkCap"
        "HPSysInfoCap"
        "HpTouchpointAnalyticsService"
        #hyper-v services
         "HvHost"                          
        "vmickvpexchange"
        "vmicguestinterface"
        "vmicshutdown"
        "vmicheartbeat"
        "vmicvmsession"
        "vmicrdv"
        "vmictimesync" 
        # Services which cannot be disabled
        #"WdNisSvc"
        )
        
        foreach ($service in $services) {
        
        
            # -ErrorAction SilentlyContinue is so it doesn't write an error to stdout if a service doesn't exist
        
        
            Write-Host "Setting $service StartupType to Manual"
            Get-Service -Name $service -ErrorAction SilentlyContinue | Set-Service -StartupType Manual
        }
    
<#
    $laptopnumlock.Add_Click({
        Set-ItemProperty -Path "HKU:\.DEFAULT\Control Panel\Keyboard" -Name "InitialKeyboardIndicators" -Type DWord -Value 0
        Add-Type -AssemblyName System.Windows.Forms
        If (([System.Windows.Forms.Control]::IsKeyLocked('NumLock'))) {
            $wsh = New-Object -ComObject WScript.Shell
            $wsh.SendKeys('{NUMLOCK}')
        }
    })

    
        Write-Host "Showing Task View button..."
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ShowTaskViewButton" -Type DWord -Value 1
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People" -Name "PeopleBand" -Type DWord -Value 1
    

    $windowssearch.Add_Click({
    
        Write-Host "Disabling Bing Search in Start Menu..."
        $ResultText.text = "`r`n" +"`r`n" + "Disabling Search, Cortana, Start menu search... Please Wait"
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Search" -Name "BingSearchEnabled" -Type DWord -Value 0
        <#
        Write-Host "Disabling Cortana"
        Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" -Name "CortanaConsent" -Type DWord -Value 0
        If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search")) {
            New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search" -Force | Out-Null
        }
        #><#


        Write-Host "Hiding Search Box / Button..."
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Search" -Name "SearchboxTaskbarMode" -Type DWord -Value 0



        Write-Host "Removing Start Menu Tiles"

        Set-Content -Path 'C:\Users\Default\AppData\Local\Microsoft\Windows\Shell\DefaultLayouts.xml' -Value '<LayoutModificationTemplate xmlns:defaultlayout="http://schemas.microsoft.com/Start/2014/FullDefaultLayout" xmlns:start="http://schemas.microsoft.com/Start/2014/StartLayout" Version="1" xmlns="http://schemas.microsoft.com/Start/2014/LayoutModification">'
        Add-Content -Path 'C:\Users\Default\AppData\Local\Microsoft\Windows\Shell\DefaultLayouts.xml' -value '  <LayoutOptions StartTileGroupCellWidth="6" />'
        Add-Content -Path 'C:\Users\Default\AppData\Local\Microsoft\Windows\Shell\DefaultLayouts.xml' -value '  <DefaultLayoutOverride>'
        Add-Content -Path 'C:\Users\Default\AppData\Local\Microsoft\Windows\Shell\DefaultLayouts.xml' -value '    <StartLayoutCollection>'
        Add-Content -Path 'C:\Users\Default\AppData\Local\Microsoft\Windows\Shell\DefaultLayouts.xml' -value '      <defaultlayout:StartLayout GroupCellWidth="6" />'
        Add-Content -Path 'C:\Users\Default\AppData\Local\Microsoft\Windows\Shell\DefaultLayouts.xml' -value '    </StartLayoutCollection>'
        Add-Content -Path 'C:\Users\Default\AppData\Local\Microsoft\Windows\Shell\DefaultLayouts.xml' -value '  </DefaultLayoutOverride>'
        Add-Content -Path 'C:\Users\Default\AppData\Local\Microsoft\Windows\Shell\DefaultLayouts.xml' -value '    <CustomTaskbarLayoutCollection>'
        Add-Content -Path 'C:\Users\Default\AppData\Local\Microsoft\Windows\Shell\DefaultLayouts.xml' -value '      <defaultlayout:TaskbarLayout>'
        Add-Content -Path 'C:\Users\Default\AppData\Local\Microsoft\Windows\Shell\DefaultLayouts.xml' -value '        <taskbar:TaskbarPinList>'
        Add-Content -Path 'C:\Users\Default\AppData\Local\Microsoft\Windows\Shell\DefaultLayouts.xml' -value '          <taskbar:UWA AppUserModelID="Microsoft.MicrosoftEdge_8wekyb3d8bbwe!MicrosoftEdge" />'
        Add-Content -Path 'C:\Users\Default\AppData\Local\Microsoft\Windows\Shell\DefaultLayouts.xml' -value '          <taskbar:DesktopApp DesktopApplicationLinkPath="%APPDATA%\Microsoft\Windows\Start Menu\Programs\System Tools\File Explorer.lnk" />'
        Add-Content -Path 'C:\Users\Default\AppData\Local\Microsoft\Windows\Shell\DefaultLayouts.xml' -value '        </taskbar:TaskbarPinList>'
        Add-Content -Path 'C:\Users\Default\AppData\Local\Microsoft\Windows\Shell\DefaultLayouts.xml' -value '      </defaultlayout:TaskbarLayout>'
        Add-Content -Path 'C:\Users\Default\AppData\Local\Microsoft\Windows\Shell\DefaultLayouts.xml' -value '    </CustomTaskbarLayoutCollection>'
        Add-Content -Path 'C:\Users\Default\AppData\Local\Microsoft\Windows\Shell\DefaultLayouts.xml' -value '</LayoutModificationTemplate>'

        $START_MENU_LAYOUT = @"
        <LayoutModificationTemplate xmlns:defaultlayout="http://schemas.microsoft.com/Start/2014/FullDefaultLayout" xmlns:start="http://schemas.microsoft.com/Start/2014/StartLayout" Version="1" xmlns:taskbar="http://schemas.microsoft.com/Start/2014/TaskbarLayout" xmlns="http://schemas.microsoft.com/Start/2014/LayoutModification">
            <LayoutOptions StartTileGroupCellWidth="6" />
            <DefaultLayoutOverride>
                <StartLayoutCollection>
                    <defaultlayout:StartLayout GroupCellWidth="6" />
                </StartLayoutCollection>
            </DefaultLayoutOverride>
        </LayoutModificationTemplate>
"@

        $layoutFile="C:\Windows\StartMenuLayout.xml"

        #Delete layout file if it already exists
        If(Test-Path $layoutFile)
        {
            Remove-Item $layoutFile
        }

        #Creates the blank layout file
        $START_MENU_LAYOUT | Out-File $layoutFile -Encoding ASCII

        $regAliases = @("HKLM", "HKCU")

        #Assign the start layout and force it to apply with "LockedStartLayout" at both the machine and user level
        foreach ($regAlias in $regAliases){
            $basePath = $regAlias + ":\SOFTWARE\Policies\Microsoft\Windows"
            $keyPath = $basePath + "\Explorer"
            IF(!(Test-Path -Path $keyPath)) {
                New-Item -Path $basePath -Name "Explorer"
            }
            Set-ItemProperty -Path $keyPath -Name "LockedStartLayout" -Value 1
            Set-ItemProperty -Path $keyPath -Name "StartLayoutFile" -Value $layoutFile
        }

        #Restart Explorer, open the start menu (necessary to load the new layout), and give it a few seconds to process
        Stop-Process -name explorer
        Start-Sleep -s 5
        $wshell = New-Object -ComObject wscript.shell; $wshell.SendKeys('^{ESCAPE}')
        Start-Sleep -s 5

        #Enable the ability to pin items again by disabling "LockedStartLayout"
        foreach ($regAlias in $regAliases){
            $basePath = $regAlias + ":\SOFTWARE\Policies\Microsoft\Windows"
            $keyPath = $basePath + "\Explorer"
            Set-ItemProperty -Path $keyPath -Name "LockedStartLayout" -Value 0

        
        
            Write-Host "Search and Start Menu Tweaks Complete"
        $ResultText.text = "`r`n" +"`r`n" + "Search and Start Menu Tweaks Complete"
        }
    })


    $Bloatware = @(

        #Unnecessary Windows 10 AppX Apps
        "Microsoft.3DBuilder"
        "Microsoft.Microsoft3DViewer"
        "Microsoft.AppConnector"
        "Microsoft.BingFinance"
        "Microsoft.BingNews"
        "Microsoft.BingSports"
        "Microsoft.BingTranslator"
        "Microsoft.BingWeather"
        "Microsoft.BingFoodAndDrink"
        "Microsoft.BingHealthAndFitness"
        "Microsoft.BingTravel"
        "Microsoft.MinecraftUWP"
        "Microsoft.GamingServices"
        # "Microsoft.WindowsReadingList"
        "Microsoft.GetHelp"
        "Microsoft.Getstarted"
        "Microsoft.Messaging"
        "Microsoft.Microsoft3DViewer"
        "Microsoft.MicrosoftSolitaireCollection"
        "Microsoft.NetworkSpeedTest"
        "Microsoft.News"
        "Microsoft.Office.Lens"
        "Microsoft.Office.Sway"
        "Microsoft.Office.OneNote"
        "Microsoft.OneConnect"
        "Microsoft.People"
        "Microsoft.Print3D"
        "Microsoft.SkypeApp"
        "Microsoft.Wallet"
        "Microsoft.Whiteboard"
        "Microsoft.WindowsAlarms"
        "microsoft.windowscommunicationsapps"
        "Microsoft.WindowsFeedbackHub"
        "Microsoft.WindowsMaps"
        "Microsoft.WindowsPhone"
        "Microsoft.WindowsSoundRecorder"
        "Microsoft.XboxApp"
        "Microsoft.ConnectivityStore"
        "Microsoft.CommsPhone"
        "Microsoft.ScreenSketch"
        "Microsoft.Xbox.TCUI"
        "Microsoft.XboxGameOverlay"
        "Microsoft.XboxGameCallableUI"
        "Microsoft.XboxSpeechToTextOverlay"
        "Microsoft.MixedReality.Portal"
        "Microsoft.XboxIdentityProvider"
        "Microsoft.ZuneMusic"
        "Microsoft.ZuneVideo"
        "Microsoft.YourPhone"
        "Microsoft.Getstarted"
        "Microsoft.MicrosoftOfficeHub"

        #Sponsored Windows 10 AppX Apps
        #Add sponsored/featured apps to remove in the "*AppName*" format
        "*EclipseManager*"
        "*ActiproSoftwareLLC*"
        "*AdobeSystemsIncorporated.AdobePhotoshopExpress*"
        "*Duolingo-LearnLanguagesforFree*"
        "*PandoraMediaInc*"
        "*CandyCrush*"
        "*BubbleWitch3Saga*"
        "*Wunderlist*"
        "*Flipboard*"
        "*Twitter*"
        "*Facebook*"
        "*Royal Revolt*"
        "*Sway*"
        "*Speed Test*"
        "*Dolby*"
        "*Viber*"
        "*ACGMediaPlayer*"
        "*Netflix*"
        "*OneCalendar*"
        "*LinkedInforWindows*"
        "*HiddenCityMysteryofShadows*"
        "*Hulu*"
        "*HiddenCity*"
        "*AdobePhotoshopExpress*"
        "*HotspotShieldFreeVPN*"

        #Optional: Typically not removed but you can if you need to for some reason
        "*Microsoft.Advertising.Xaml*"
        #"*Microsoft.MSPaint*"
        #"*Microsoft.MicrosoftStickyNotes*"
        #"*Microsoft.Windows.Photos*"
        #"*Microsoft.WindowsCalculator*"
        #"*Microsoft.WindowsStore*"
    )


    $removebloat.Add_Click({

        Write-Host "Removing Bloatware"

        foreach ($Bloat in $Bloatware) {
            Get-AppxPackage -Name $Bloat| Remove-AppxPackage
            Get-AppxProvisionedPackage -Online | Where-Object DisplayName -like $Bloat | Remove-AppxProvisionedPackage -Online
            Write-Host "Trying to remove $Bloat."
            $ResultText.text = "`r`n" +"`r`n" + "Trying to remove $Bloat."
        }

    
        Write-Host "Finished Removing Bloatware Apps"
        $ResultText.text = "`r`n" +"`r`n" + "Finished Removing Bloatware Apps"
    })


    $reinstallbloat.Add_Click({
    
        Write-Host "Reinstalling Bloatware"

        foreach ($app in $Bloatware) {
            Write-Output "Trying to add $app"
            $ResultText.text = "`r`n" +"`r`n" + "Trying to add $app"
            Add-AppxPackage -DisableDevelopmentMode -Register "$($(Get-AppxPackage -AllUsers $app).InstallLocation)\AppXManifest.xml"
        }


        Write-Host "Finished Reinstalling Bloatware Apps"
        $ResultText.text = "`r`n" +"`r`n" + "Finished Reinstalling Bloatware Apps"
    })
#>

    ##############################################################
    $defaultwindowsupdate.Add_Click({

        Write-Host "Enabling driver offering through Windows Update..."
        Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Device Metadata" -Name "PreventDeviceMetadataFromNetwork" -ErrorAction SilentlyContinue
        Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DriverSearching" -Name "DontPromptForWindowsUpdate" -ErrorAction SilentlyContinue
        Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DriverSearching" -Name "DontSearchWindowsUpdate" -ErrorAction SilentlyContinue
        Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DriverSearching" -Name "DriverUpdateWizardWuSearchEnabled" -ErrorAction SilentlyContinue
        Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" -Name "ExcludeWUDriversInQualityUpdate" -ErrorAction SilentlyContinue


        Write-Host "Enabling Windows Update automatic restart..."
        Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" -Name "NoAutoRebootWithLoggedOnUsers" -ErrorAction SilentlyContinue
        Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" -Name "AUPowerManagement" -ErrorAction SilentlyContinue


        Write-Host "Enabled driver offering through Windows Update"
        $ResultText.text = "`r`n" +"`r`n" + "Set Windows Updates to Stock Settings"
    })


    $securitywindowsupdate.Add_Click({

        Write-Host "Disabling driver offering through Windows Update..."
        If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Device Metadata")) {
            New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Device Metadata" -Force | Out-Null
        }
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Device Metadata" -Name "PreventDeviceMetadataFromNetwork" -Type DWord -Value 1
        If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DriverSearching")) {
            New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DriverSearching" -Force | Out-Null
        }
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DriverSearching" -Name "DontPromptForWindowsUpdate" -Type DWord -Value 1
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DriverSearching" -Name "DontSearchWindowsUpdate" -Type DWord -Value 1
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DriverSearching" -Name "DriverUpdateWizardWuSearchEnabled" -Type DWord -Value 0
        If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate")) {
            New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" | Out-Null
        }
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" -Name "ExcludeWUDriversInQualityUpdate" -Type DWord -Value 1


        Write-Host "Disabling Windows Update automatic restart..."
        If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU")) {
            New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" -Force | Out-Null
        }
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" -Name "NoAutoRebootWithLoggedOnUsers" -Type DWord -Value 1
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" -Name "AUPowerManagement" -Type DWord -Value 0


        Write-Host "Disabled driver offering through Windows Update"
        $ResultText.text = "`r`n" +"`r`n" + "Set Windows Update to Sane Settings"
    })

<#
    $HTrayIcons.Add_Click({

    	Write-Host "Hiding tray icons..."
    	Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" -Name "EnableAutoTray" -Type DWord -Value 1
    

        Write-Host "Done - Hid Tray Icons"
        $ResultText.text = "`r`n" +"`r`n" + "Tray icons are now factory defaults"
    })


    $STrayIcons.Add_Click({

    	Write-Host "Showing tray icons..."
    	Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" -Name "EnableAutoTray" -Type DWord -Value 0
    

        Write-Host "Done - Now showing all tray icons"
        $ResultText.text = "`r`n" +"`r`n" + "Tray Icons now set to show all"
    })


    $DisableNumLock.Add_Click({

        Write-Host "Disable NumLock after startup..."
        Set-ItemProperty -Path "HKU:\.DEFAULT\Control Panel\Keyboard" -Name "InitialKeyboardIndicators" -Type DWord -Value 0
        Add-Type -AssemblyName System.Windows.Forms
        If (([System.Windows.Forms.Control]::IsKeyLocked('NumLock'))) {
            $wsh = New-Object -ComObject WScript.Shell
            $wsh.SendKeys('{NUMLOCK}')
        }
        $ResultText.text = "`r`n" +"`r`n" + "NUMLOCK Disabled"
    })
#>
######################################################
    $yourphonefix.Add_Click({

        
    })


    $ncpa.Add_Click({
        cmd /c ncpa.cpl
    })
    $oldsoundpanel.Add_Click({
        cmd /c mmsys.cpl
    })
    $oldcontrolpanel.Add_Click({
        cmd /c control
    })
    $oldsystempanel.Add_Click({
        cmd /c sysdm.cpl
    })
    




    $NFS.Add_Click({

        
    })


    $Virtualization.Add_Click({

        
        $ResultText.text = "`r`n" +"`r`n" + "HyperV is now installed and configured. Please Reboot before using."
    })


    $windowsupdatefix.Add_Click({
    
        

    })


    $disableupdates.Add_Click({

        # Source: https://github.com/rgl/windows-vagrant/blob/master/disable-windows-updates.ps1
        Set-StrictMode -Version Latest
        $ProgressPreference = 'SilentlyContinue'
        $ErrorActionPreference = 'Stop'
        trap {
            Write-Host
            Write-Host "ERROR: $_"
            Write-Host (($_.ScriptStackTrace -split '\r?\n') -replace '^(.*)$','ERROR: $1')
            Write-Host (($_.Exception.ToString() -split '\r?\n') -replace '^(.*)$','ERROR EXCEPTION: $1')
            Write-Host
            Write-Host 'Sleeping for 60m to give you time to look around the virtual machine before self-destruction...'
        Start-Sleep -Seconds (60*60)
        Exit 1
        }

        # disable automatic updates.
        # XXX this does not seem to work anymore.
        # see How to configure automatic updates by using Group Policy or registry settings
        #     at https://support.microsoft.com/en-us/help/328010

        function New-Directory($path) {
        $p, $components = $path -split '[\\/]'
        $components | ForEach-Object {
            $p = "$p\$_"
            if (!(Test-Path $p)) {
                New-Item -ItemType Directory $p | Out-Null
            }
        }
        $null
        }
        $auPath = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU'
        New-Directory $auPath 
        # set NoAutoUpdate.
        # 0: Automatic Updates is enabled (default).
        # 1: Automatic Updates is disabled.
        New-ItemProperty `
            -Path $auPath `
            -Name NoAutoUpdate `
            -Value 1 `
            -PropertyType DWORD `
            -Force `
            | Out-Null
        # set AUOptions.
        # 1: Keep my computer up to date has been disabled in Automatic Updates.
        # 2: Notify of download and installation.
        # 3: Automatically download and notify of installation.
        # 4: Automatically download and scheduled installation.
        New-ItemProperty `
            -Path $auPath `
            -Name AUOptions `
            -Value 1 `
            -PropertyType DWORD `
            -Force `
            | Out-Null

        # disable Windows Update Delivery Optimization.
        # NB this applies to Windows 10.
        # 0: Disabled
        # 1: PCs on my local network
        # 3: PCs on my local network, and PCs on the Internet
        $deliveryOptimizationPath = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Config'
        if (Test-Path $deliveryOptimizationPath) {
            New-ItemProperty `
                -Path $deliveryOptimizationPath `
                -Name DODownloadMode `
                -Value 0 `
                -PropertyType DWORD `
                -Force `
                | Out-Null
        }
        # Service tweaks for Windows Update

        $services = @(
            "BITS"
            "wuauserv"
        )

        foreach ($service in $services) {
            # -ErrorAction SilentlyContinue is so it doesn't write an error to stdout if a service doesn't exist

            Write-Host "Setting $service StartupType to Disabled"
            Get-Service -Name $service -ErrorAction SilentlyContinue | Set-Service -StartupType Disabled
        }
    })


    $enableupdates.Add_Click({

        # Source: https://github.com/rgl/windows-vagrant/blob/master/disable-windows-updates.ps1
        Set-StrictMode -Version Latest
        $ProgressPreference = 'SilentlyContinue'
        $ErrorActionPreference = 'Stop'
        trap {
            Write-Host
            Write-Host "ERROR: $_"
            Write-Host (($_.ScriptStackTrace -split '\r?\n') -replace '^(.*)$','ERROR: $1')
            Write-Host (($_.Exception.ToString() -split '\r?\n') -replace '^(.*)$','ERROR EXCEPTION: $1')
            Write-Host
            Write-Host 'Sleeping for 60m to give you time to look around the virtual machine before self-destruction...'
            Start-Sleep -Seconds (60*60)
            Exit 1
        }

        # disable automatic updates.
        # XXX this does not seem to work anymore.
        # see How to configure automatic updates by using Group Policy or registry settings
        #     at https://support.microsoft.com/en-us/help/328010
        function New-Directory($path) {
                $p, $components = $path -split '[\\/]'
            $components | ForEach-Object {
                $p = "$p\$_"
                if (!(Test-Path $p)) {
                    New-Item -ItemType Directory $p | Out-Null
                }
            }
            $null
        }
        $auPath = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU'
        New-Directory $auPath 
        # set NoAutoUpdate.
        # 0: Automatic Updates is enabled (default).
        # 1: Automatic Updates is disabled.
        New-ItemProperty `
            -Path $auPath `
            -Name NoAutoUpdate `
            -Value 0 `
            -PropertyType DWORD `
            -Force `
            | Out-Null
        # set AUOptions.
        # 1: Keep my computer up to date has been disabled in Automatic Updates.
        # 2: Notify of download and installation.
        # 3: Automatically download and notify of installation.
        # 4: Automatically download and scheduled installation.
        New-ItemProperty `
            -Path $auPath `
            -Name AUOptions `
            -Value 3 `
            -PropertyType DWORD `
            -Force `
            | Out-Null

        # disable Windows Update Delivery Optimization.
        # NB this applies to Windows 10.
        # 0: Disabled
        # 1: PCs on my local network
        # 3: PCs on my local network, and PCs on the Internet
        $deliveryOptimizationPath = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Config'
        if (Test-Path $deliveryOptimizationPath) {
            New-ItemProperty `
                -Path $deliveryOptimizationPath `
                -Name DODownloadMode `
                -Value 0 `
                -PropertyType DWORD `
                -Force `
                | Out-Null
        }
        # Service tweaks for Windows Update

        $services = @(
            "BITS"
            "wuauserv"
        )

        foreach ($service in $services) {
            # -ErrorAction SilentlyContinue is so it doesn't write an error to stdout if a service doesn't exist

            Write-Host "Setting $service StartupType to Automatic"
            Get-Service -Name $service -ErrorAction SilentlyContinue | Set-Service -StartupType Automatic
        }
    })