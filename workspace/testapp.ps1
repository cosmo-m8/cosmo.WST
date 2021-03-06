Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.Application]::EnableVisualStyles()


#--------------------GET ADMIN PRIVILEGE--------------------

$ErrorActionPreference = 'SilentlyContinue'
$wshell = New-Object -ComObject Wscript.Shell
$Button = [System.Windows.MessageBoxButton]::YesNoCancel
$ErrorIco = [System.Windows.MessageBoxImage]::Error
If (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]'Administrator')) {
	Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
	Exit
}


#--------------------GLOBAL VARIABLES--------------------
$ver            = "v0.8.0-220413"
#$colBG			= "#e9e9e9"			# Grey 				- Forms
#$colBG			= "#8BC34A"			# Light Green 500	- Forms
#$colBG			= "#7986CB"			# Indigo 300		- Forms
$colBG			= "#9FA8DA"			# Indigo 300		- Forms
$colSEP			= "#BDBDBD"			# Grey 400			- Seperator Panels
$colLOG			= "#90A4AE"			# Blue Gray 300		- Log Box
$colTIT			= "#DD2C00"			# Deep Purple 900	- Titles
$colcosmo		= "#7E57C2"			# Deep Purple 400 	- Button cosmo
$colBT          = "#4DB6AC"			# Teal 300	 		- Button Standard
$colUN			= "#FF7043"			# Deep Orange 400	- Button Undo
$col1			= "#1565C0"			# Blue 				- Button Essentials
$col2			= "#EF5350"			# Red 				- Button Important (Chocolatey/RestorPt)


#--------MAX FRAME SIZE CHECK--------
$MaxWid = [System.Windows.Forms.Screen]::PrimaryScreen.WorkingArea.Width
$MaxHei = [System.Windows.Forms.Screen]::PrimaryScreen.WorkingArea.Height


#--------------------TOOLTIPS INIT--------------------
$instTT                          = New-Object System.Windows.Forms.ToolTip
$instTT.AutoPopDelay             = 32000
$instTT.InitialDelay             = 200
$instTT.ReshowDelay              = 100
$instTT.ShowAlways               = $True
$instTT.ToolTipIcon              = "Warning"
$instTT.ToolTipTitle             = "INSTALLS:"

$genTT                           = New-Object System.Windows.Forms.ToolTip
$genTT.AutoPopDelay              = 32000
$genTT.InitialDelay              = 300
$genTT.ReshowDelay               = 100
$genTT.ShowAlways                = $True
$genTT.ToolTipIcon               = "Info"
$genTT.ToolTipTitle              = "More Info:"


#--------------------GUI SPECS--------------------
$Form                            = New-Object system.Windows.Forms.Form
$Form.ClientSize                 = New-Object System.Drawing.Point(1050,400)
$Form.text                       = "cosmo.WST ??? Windows Setup Toolbox by cosmo"
$Form.StartPosition              = "CenterScreen"
$Form.TopMost                    = $false
$Form.BackColor                  = [System.Drawing.ColorTranslator]::FromHtml($colBG)
$Form.AutoScaleDimensions     = '192, 192'
$Form.AutoScaleMode           = "Dpi"
$Form.AutoSize                = $True
$Form.AutoScroll              = $True
$Form.FormBorderStyle         = 'FixedSingle'
$Form.MaximumSize             = New-Object System.Drawing.Size($MaxWid, $MaxHei)


#--------------------GUI ELEMENTS--------------------

$backPN                          = New-Object system.Windows.Forms.Panel
$backPN.height                   = 527
$backPN.width                    = 1009
$backPN.location                 = New-Object System.Drawing.Point(3,3)
$backPN.BackColor = "#9FA8DA"

#--------INSTALL SECTION--------
$installLB                       = New-Object system.Windows.Forms.Label
$installLB.text                  = "Install"
$installLB.AutoSize              = $true
$installLB.width                 = 152
$installLB.height                = 25
$installLB.location              = New-Object System.Drawing.Point(38,10)
$installLB.Font                  = New-Object System.Drawing.Font('Calibri',24,[System.Drawing.FontStyle]::Bold)
$installLB.ForeColor             = $colTIT

$choco                           = New-Object system.Windows.Forms.Button
$choco.text                      = "Chocolatey"
$choco.width                     = 150
$choco.height                    = 30
$choco.location                  = New-Object System.Drawing.Point(11,54)
$choco.Font                      = New-Object System.Drawing.Font('Microsoft Sans Serif',12)
$choco.BackColor                 = $col2

$installPN                       = New-Object system.Windows.Forms.Panel
$installPN.height                = 466
$installPN.width                 = 152
$installPN.location              = New-Object System.Drawing.Point(10,53)
$installPN.BackColor = "#4EC5F1"
$installPN.Enabled = $false

$bundlesLB                       = New-Object system.Windows.Forms.Label
$bundlesLB.text                  = "Bundles:"
$bundlesLB.AutoSize              = $true
$bundlesLB.width                 = 25
$bundlesLB.height                = 10
$bundlesLB.location              = New-Object System.Drawing.Point(0,43)
$bundlesLB.Font                  = New-Object System.Drawing.Font('Microsoft Sans Serif',10,[System.Drawing.FontStyle]::Bold)

$cosmo                           = New-Object system.Windows.Forms.Button
$cosmo.text                      = "cosmoPack"
$cosmo.width                     = 150
$cosmo.height                    = 30
$cosmo.location                  = New-Object System.Drawing.Point(1,63)
$cosmo.Font                      = New-Object System.Drawing.Font('Microsoft Sans Serif',12)
$cosmo.BackColor                 = $colcosmo
$instTT.SetToolTip($cosmo, "7-Zip`r`nVLC`r`n---`r`nSumatra PDF`r`nLibreOffice`r`n---`r`nGoogle Chrome`r`nGoogle Drive`r`n---`r`nGIMP`r`nVSCode`r`nNotepad++`r`nWindows Terminal")

$essentials                      = New-Object system.Windows.Forms.Button
$essentials.text                 = "Essentials"
$essentials.width                = 150
$essentials.height               = 30
$essentials.location             = New-Object System.Drawing.Point(1,94)
$essentials.Font                 = New-Object System.Drawing.Font('Microsoft Sans Serif',12)
$essentials.BackColor            = $col1
$instTT.SetToolTip($essentials, "7-Zip`r`nVLC`r`n---`r`nSumatra PDF`r`nLibreOffice`r`n---`r`nGoogle Chrome")

$doctools                        = New-Object system.Windows.Forms.Button
$doctools.text                   = "Document Tools"
$doctools.width                  = 150
$doctools.height                 = 30
$doctools.location               = New-Object System.Drawing.Point(1,125)
$doctools.Font                   = New-Object System.Drawing.Font('Microsoft Sans Serif',12)
$doctools.BackColor              = $colBT
$instTT.SetToolTip($doctools, "SumatraPDF`r`n---`r`nLibreOffice`r`nNotepad++")

$mediatools                      = New-Object system.Windows.Forms.Button
$mediatools.text                 = "Media Tools"
$mediatools.width                = 150
$mediatools.height               = 30
$mediatools.location             = New-Object System.Drawing.Point(1,156)
$mediatools.Font                 = New-Object System.Drawing.Font('Microsoft Sans Serif',12)
$mediatools.BackColor            = $colBT
$instTT.SetToolTip($mediatools, "VLC`r`nGIMP`r`nAudaCity`r`nFileZilla")

$consumption                     = New-Object system.Windows.Forms.Button
$consumption.text                = "Consumption"
$consumption.width               = 150
$consumption.height              = 30
$consumption.location            = New-Object System.Drawing.Point(1,187)
$consumption.Font                = New-Object System.Drawing.Font('Microsoft Sans Serif',12)
$consumption.BackColor           = $colBT
$instTT.SetToolTip($consumption, "Steam`r`niTunes")

$devtools                        = New-Object system.Windows.Forms.Button
$devtools.text                   = "Development"
$devtools.width                  = 150
$devtools.height                 = 30
$devtools.location               = New-Object System.Drawing.Point(1,218)
$devtools.Font                   = New-Object System.Drawing.Font('Microsoft Sans Serif',12)
$devtools.BackColor              = $colBT
$instTT.SetToolTip($devtools, "GIMP`r`nAudaCity`r`nVSCode`r`nNotepad++`r`nWindows Terminal`r`nFileZilla`r`nGIT")

$deps                            = New-Object system.Windows.Forms.Button
$deps.text                       = "Dependencies"
$deps.width                      = 150
$deps.height                     = 30
$deps.location                   = New-Object System.Drawing.Point(1,249)
$deps.Font                       = New-Object System.Drawing.Font('Microsoft Sans Serif',12)
$deps.BackColor                  = $colBT
$instTT.SetToolTip($deps, "Java Runtime Environment`r`nGIT")

$tmpBT6                          = New-Object system.Windows.Forms.Button
$tmpBT6.text                     = "comming soon"
$tmpBT6.width                    = 150
$tmpBT6.height                   = 30
$tmpBT6.location                 = New-Object System.Drawing.Point(1,280)
$tmpBT6.Font                     = New-Object System.Drawing.Font('Microsoft Sans Serif',12)
$tmpBT6.BackColor                = $colBT
$tmpBT6.Enabled = $false

$miscLB                          = New-Object system.Windows.Forms.Label
$miscLB.text                     = "Miscellaneous:"
$miscLB.AutoSize                 = $true
$miscLB.width                    = 25
$miscLB.height                   = 10
$miscLB.location                 = New-Object System.Drawing.Point(0,322)
$miscLB.Font                     = New-Object System.Drawing.Font('Microsoft Sans Serif',10,[System.Drawing.FontStyle]([System.Drawing.FontStyle]::Bold))

$openAppForm                     = New-Object system.Windows.Forms.Button
$openAppForm.text                = "App Installer"
$openAppForm.width               = 150
$openAppForm.height              = 30
$openAppForm.location            = New-Object System.Drawing.Point(1,342)
$openAppForm.Font                = New-Object System.Drawing.Font('Microsoft Sans Serif',12)
$openAppForm.BackColor           = $colBT
$genTT.SetToolTip($openAppForm, "Opens menu for installing`r`nindividual Software")

$updChocos                       = New-Object system.Windows.Forms.Button
$updChocos.text                  = "Update Apps"
$updChocos.width                 = 150
$updChocos.height                = 30
$updChocos.location              = New-Object System.Drawing.Point(1,373)
$updChocos.Font                  = New-Object System.Drawing.Font('Microsoft Sans Serif',12)
$updChocos.BackColor             = $colBT
$genTT.SetToolTip($updChocos, "Updates any Software`r`ninstalled with Chocolatey")

$tmpBT9                          = New-Object system.Windows.Forms.Button
$tmpBT9.text                     = "comming soon"
$tmpBT9.width                    = 150
$tmpBT9.height                   = 30
$tmpBT9.location                 = New-Object System.Drawing.Point(1,404)
$tmpBT9.Font                     = New-Object System.Drawing.Font('Microsoft Sans Serif',12)
$tmpBT9.BackColor                = $colBT
$tmpBT9.Enabled = $false

$tmpBT10                         = New-Object system.Windows.Forms.Button
$tmpBT10.text                    = "comming soon"
$tmpBT10.width                   = 150
$tmpBT10.height                  = 30
$tmpBT10.location                = New-Object System.Drawing.Point(1,435)
$tmpBT10.Font                    = New-Object System.Drawing.Font('Microsoft Sans Serif',12)
$tmpBT10.BackColor               = $colBT
$tmpBT10.Enabled = $false

#--------SEPERATOR--------
$line1PN                         = New-Object system.Windows.Forms.Panel
$line1PN.height                  = 508
$line1PN.width                   = 2
$line1PN.location                = New-Object System.Drawing.Point(177,10)
$line1PN.BackColor               = $colSEP

#--------TWEAKS SECTION--------
$tweaksLB                        = New-Object system.Windows.Forms.Label
$tweaksLB.text                   = "Tweaks"
$tweaksLB.AutoSize               = $true
$tweaksLB.width                  = 100
$tweaksLB.height                 = 25
$tweaksLB.location               = New-Object System.Drawing.Point(243,10)
$tweaksLB.Font                   = New-Object System.Drawing.Font('Calibri',24, [System.Drawing.FontStyle]::Bold)

$tweaksPN                        = New-Object system.Windows.Forms.Panel
$tweaksPN.height                 = 466
$tweaksPN.width                  = 202
$tweaksPN.location               = New-Object System.Drawing.Point(194,53)
$tweaksPN.BackColor = "#FF7043"

$restorePt                       = New-Object system.Windows.Forms.Button
$restorePt.text                  = "System Restore Point"
$restorePt.width                 = 200
$restorePt.height                = 30
$restorePt.location              = New-Object System.Drawing.Point(1,1)
$restorePt.Font                  = New-Object System.Drawing.Font('Microsoft Sans Serif',12)
$restorePt.BackColor             = $col2

$essenCfg                        = New-Object system.Windows.Forms.Button
$essenCfg.text                   = "Essential Tweaks"
$essenCfg.width                  = 150
$essenCfg.height                 = 30
$essenCfg.location               = New-Object System.Drawing.Point(1,32)
$essenCfg.Font                   = New-Object System.Drawing.Font('Microsoft Sans Serif',12)
$essenCfg.BackColor              = $col1
$genTT.SetToolTip($essenCfg, "??? System Restore Point`r`n??? Quality of Life`r`n??? Disable Telemetry`r`n??? Disable Location Tracking`r`n??? Disable Utilities`r`n??? Enable UTC-Time")

$UessenCfg                       = New-Object system.Windows.Forms.Button
$UessenCfg.text                  = "Undo"
$UessenCfg.width                 = 49
$UessenCfg.height                = 30
$UessenCfg.location              = New-Object System.Drawing.Point(152,32)
$UessenCfg.Font                  = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$cosmoCfg                        = New-Object system.Windows.Forms.Button
$cosmoCfg.text                   = "cosmoConfig"
$cosmoCfg.width                  = 150
$cosmoCfg.height                 = 30
$cosmoCfg.location               = New-Object System.Drawing.Point(1,63)
$cosmoCfg.Font                   = New-Object System.Drawing.Font('Microsoft Sans Serif',12)
$cosmoCfg.BackColor              = $colcosmo
$genTT.SetToolTip($cosmoCfg, "??? System Restore Point`r`n??? Quality of Life`r`n??? Dark Mode`r`n??? Disable Telemetry`r`n??? Disable Location Tracking`r`n??? Delete OneDrive`r`n??? Disable Utilities`r`n??? Enable UTC-Time")

$UcosmoCfg                       = New-Object system.Windows.Forms.Button
$UcosmoCfg.text                  = "Undo"
$UcosmoCfg.width                 = 49
$UcosmoCfg.height                = 30
$UcosmoCfg.location              = New-Object System.Drawing.Point(152,63)
$UcosmoCfg.Font                  = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$QoL                             = New-Object system.Windows.Forms.Button
$QoL.text                        = "Quality of Life"
$QoL.width                       = 150
$QoL.height                      = 30
$QoL.location                    = New-Object System.Drawing.Point(1,94)
$QoL.Font                        = New-Object System.Drawing.Font('Microsoft Sans Serif',12)
$genTT.SetToolTip($QoL, "??? Task Manager Details`r`n??? File Operations Details`r`n??? Hide People Icon`r`n??? Explorer view to This PC`r`n??? Hide 3D Objects Icon`r`n??? Network Tweaks`r`n??? Group svchost.exe Processes`r`n??? Disable News and Interests`r`n??? Remove Meet Now Button`r`n??? Show File Extensions")

$UQoL                            = New-Object system.Windows.Forms.Button
$UQoL.text                       = "Undo"
$UQoL.width                      = 49
$UQoL.height                     = 30
$UQoL.location                   = New-Object System.Drawing.Point(152,94)
$UQoL.Font                       = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$darkMode                        = New-Object system.Windows.Forms.Button
$darkMode.text                   = "Dark Mode"
$darkMode.width                  = 150
$darkMode.height                 = 30
$darkMode.location               = New-Object System.Drawing.Point(1,125)
$darkMode.Font                   = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$UdarkMode                       = New-Object system.Windows.Forms.Button
$UdarkMode.text                  = "Undo"
$UdarkMode.width                 = 49
$UdarkMode.height                = 30
$UdarkMode.location              = New-Object System.Drawing.Point(152,125)
$UdarkMode.Font                  = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$perfVfx                         = New-Object system.Windows.Forms.Button
$perfVfx.text                    = "Performance VFX"
$perfVfx.width                   = 150
$perfVfx.height                  = 30
$perfVfx.location                = New-Object System.Drawing.Point(1,156)
$perfVfx.Font                    = New-Object System.Drawing.Font('Microsoft Sans Serif',12)
$genTT.SetToolTip($perfVfx, "Adjusting visual effects`r`nfor performance")

$UperfVfx                        = New-Object system.Windows.Forms.Button
$UperfVfx.text                   = "Undo"
$UperfVfx.width                  = 49
$UperfVfx.height                 = 30
$UperfVfx.location               = New-Object System.Drawing.Point(152,156)
$UperfVfx.Font                   = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$telem                           = New-Object system.Windows.Forms.Button
$telem.text                      = "Dis. Telemetry"
$telem.width                     = 150
$telem.height                    = 30
$telem.location                  = New-Object System.Drawing.Point(1,187)
$telem.Font                      = New-Object System.Drawing.Font('Microsoft Sans Serif',12)
$genTT.SetToolTip($telem, "Disable...`r`n??? Telemetry`r`n??? Wi-Fi Sense`r`n??? Application suggestions`r`n??? Activity History`r`n??? Feedback`r`n??? Tailored Experiences`r`n??? Advertising ID`r`n??? Error reporting`r`n??? Diagnostics Tracking Service`r`n??? WAP Push Service`r`n??? AutoLogger file and restricting directory")

$Utelem                          = New-Object system.Windows.Forms.Button
$Utelem.text                     = "Undo"
$Utelem.width                    = 49
$Utelem.height                   = 30
$Utelem.location                 = New-Object System.Drawing.Point(152,187)
$Utelem.Font                     = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$loctrack                        = New-Object system.Windows.Forms.Button
$loctrack.text                   = "Dis. Loc. Track"
$loctrack.width                  = 150
$loctrack.height                 = 30
$loctrack.location               = New-Object System.Drawing.Point(1,218)
$loctrack.Font                   = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$Uloctrack                       = New-Object system.Windows.Forms.Button
$Uloctrack.text                  = "Undo"
$Uloctrack.width                 = 49
$Uloctrack.height                = 30
$Uloctrack.location              = New-Object System.Drawing.Point(152,218)
$Uloctrack.Font                  = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$oneDrive                        = New-Object system.Windows.Forms.Button
$oneDrive.text                   = "Remove OneDrive"
$oneDrive.width                  = 150
$oneDrive.height                 = 30
$oneDrive.location               = New-Object System.Drawing.Point(1,249)
$oneDrive.Font                   = New-Object System.Drawing.Font('Microsoft Sans Serif',12)
$genTT.SetToolTip($oneDrive, "Disable and Delete OneDrive")

$UoneDrive                       = New-Object system.Windows.Forms.Button
$UoneDrive.text                  = "Undo"
$UoneDrive.width                 = 49
$UoneDrive.height                = 30
$UoneDrive.location              = New-Object System.Drawing.Point(152,249)
$UoneDrive.Font                  = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$discortana                      = New-Object system.Windows.Forms.Button
$discortana.text                 = "Dis. Cortana"
$discortana.width                = 150
$discortana.height               = 30
$discortana.location             = New-Object System.Drawing.Point(1,280)
$discortana.Font                 = New-Object System.Drawing.Font('Microsoft Sans Serif',12)
$genTT.SetToolTip($discortana, "Disable Cortana including`r`nWindows Search Capability")

$Udiscortana                     = New-Object system.Windows.Forms.Button
$Udiscortana.text                = "Undo"
$Udiscortana.width               = 49
$Udiscortana.height              = 30
$Udiscortana.location            = New-Object System.Drawing.Point(152,280)
$Udiscortana.Font                = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$actionc                         = New-Object system.Windows.Forms.Button
$actionc.text                    = "Dis. ActionCenter"
$actionc.width                   = 150
$actionc.height                  = 30
$actionc.location                = New-Object System.Drawing.Point(1,311)
$actionc.Font                    = New-Object System.Drawing.Font('Microsoft Sans Serif',12)
$genTT.SetToolTip($actionc, "Disable Action Center including`r`nWindows Notifications")

$Uactionc                        = New-Object system.Windows.Forms.Button
$Uactionc.text                   = "Undo"
$Uactionc.width                  = 49
$Uactionc.height                 = 30
$Uactionc.location               = New-Object System.Drawing.Point(152,311)
$Uactionc.Font                   = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$bgApps                          = New-Object system.Windows.Forms.Button
$bgApps.text                     = "Dis. BG Apps"
$bgApps.width                    = 150
$bgApps.height                   = 30
$bgApps.location                 = New-Object System.Drawing.Point(1,342)
$bgApps.Font                     = New-Object System.Drawing.Font('Microsoft Sans Serif',12)
$genTT.SetToolTip($bgApps, "Disable Background`r`napplication access")

$UbgApps                         = New-Object system.Windows.Forms.Button
$UbgApps.text                    = "Undo"
$UbgApps.width                   = 49
$UbgApps.height                  = 30
$UbgApps.location                = New-Object System.Drawing.Point(152,342)
$UbgApps.Font                    = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$utils                           = New-Object system.Windows.Forms.Button
$utils.text                      = "Dis. Utilities"
$utils.width                     = 150
$utils.height                    = 30
$utils.location                  = New-Object System.Drawing.Point(1,373)
$utils.Font                      = New-Object System.Drawing.Font('Microsoft Sans Serif',12)
$genTT.SetToolTip($utils, "Disable...`r`n??? Home Groups services`r`n??? Remote Assistance`r`n??? Storage Sense`r`n??? Superfetch service`r`n??? Hibernation")

$Uutils                          = New-Object system.Windows.Forms.Button
$Uutils.text                     = "Undo"
$Uutils.width                    = 49
$Uutils.height                   = 30
$Uutils.location                 = New-Object System.Drawing.Point(152,373)
$Uutils.Font                     = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$clipbH                          = New-Object system.Windows.Forms.Button
$clipbH.text                     = "Dis. Clip. History"
$clipbH.width                    = 150
$clipbH.height                   = 30
$clipbH.location                 = New-Object System.Drawing.Point(1,404)
$clipbH.Font                     = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$UclipbH                         = New-Object system.Windows.Forms.Button
$UclipbH.text                    = "Undo"
$UclipbH.width                   = 49
$UclipbH.height                  = 30
$UclipbH.location                = New-Object System.Drawing.Point(152,404)
$UclipbH.Font                    = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$UTCTime                         = New-Object system.Windows.Forms.Button
$UTCTime.text                    = "Enable UTC Time"
$UTCTime.width                   = 150
$UTCTime.height                  = 30
$UTCTime.location                = New-Object System.Drawing.Point(1,435)
$UTCTime.Font                    = New-Object System.Drawing.Font('Microsoft Sans Serif',12)
$genTT.SetToolTip($UTCTime, "Set BIOS time to UTC`r`nfor consistent time in`r`nDual Boot Systems")

$UUTCTime                        = New-Object system.Windows.Forms.Button
$UUTCTime.text                   = "Undo"
$UUTCTime.width                  = 49
$UUTCTime.height                 = 30
$UUTCTime.location               = New-Object System.Drawing.Point(152,435)
$UUTCTime.Font                   = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

#--------SEPERATOR--------
$line2PN                         = New-Object system.Windows.Forms.Panel
$line2PN.height                  = 508
$line2PN.width                   = 2
$line2PN.location                = New-Object System.Drawing.Point(411,10)
$line2PN.BackColor               = $colSEP

#--------FIXES/TOOLS SECTION--------
$fixesLB                         = New-Object system.Windows.Forms.Label
$fixesLB.text                    = "Fixes/Tools"
$fixesLB.AutoSize                = $true
$fixesLB.width                   = 100
$fixesLB.height                  = 25
$fixesLB.location                = New-Object System.Drawing.Point(446,10)
$fixesLB.Font                    = New-Object System.Drawing.Font('Calibri',24, [System.Drawing.FontStyle]::Bold)

$fixesPN                         = New-Object system.Windows.Forms.Panel
$fixesPN.height                  = 466
$fixesPN.width                   = 202
$fixesPN.location                = New-Object System.Drawing.Point(428,53)
$fixesPN.BackColor = "#689F38"

$phoneFix                        = New-Object system.Windows.Forms.Button
$phoneFix.text                   = "Your Phone Fix"
$phoneFix.width                  = 200
$phoneFix.height                 = 30
$phoneFix.location               = New-Object System.Drawing.Point(1,1)
$phoneFix.Font                   = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$updReset                        = New-Object system.Windows.Forms.Button
$updReset.text                   = "Win Update Reset"
$updReset.width                  = 200
$updReset.height                 = 30
$updReset.location               = New-Object System.Drawing.Point(1,32)
$updReset.Font                   = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$power                           = New-Object system.Windows.Forms.Button
$power.text                      = "Restore Power Options"
$power.width                     = 200
$power.height                    = 30
$power.location                  = New-Object System.Drawing.Point(1,63)
$power.Font                      = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$powerCfg                        = New-Object system.Windows.Forms.Button
$powerCfg.text                   = "Open Power Options"
$powerCfg.width                  = 200
$powerCfg.height                 = 30
$powerCfg.location               = New-Object System.Drawing.Point(1,94)
$powerCfg.Font                   = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$hyperV                          = New-Object system.Windows.Forms.Button
$hyperV.text                     = "Enable Hyper-V + WSL"
$hyperV.width                    = 200
$hyperV.height                   = 30
$hyperV.location                 = New-Object System.Drawing.Point(1,125)
$hyperV.Font                     = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$nfs                             = New-Object system.Windows.Forms.Button
$nfs.text                        = "Enable NFS"
$nfs.width                       = 200
$nfs.height                      = 30
$nfs.location                    = New-Object System.Drawing.Point(1,156)
$nfs.Font                        = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

#--------SEPERATOR--------
$line3PN                         = New-Object system.Windows.Forms.Panel
$line3PN.height                  = 508
$line3PN.width                   = 2
$line3PN.location                = New-Object System.Drawing.Point(645,10)
$line3PN.BackColor               = $colSEP

#--------WIN UPDATE SECTION--------
$winUpdLB                        = New-Object system.Windows.Forms.Label
$winUpdLB.text                   = "Windows Update"
$winUpdLB.AutoSize               = $true
$winUpdLB.width                  = 100
$winUpdLB.height                 = 25
$winUpdLB.location               = New-Object System.Drawing.Point(714,10)
$winUpdLB.Font                   = New-Object System.Drawing.Font('Calibri',24, [System.Drawing.FontStyle]::Bold)

$updatesPN                       = New-Object system.Windows.Forms.Panel
$updatesPN.height                = 280
$updatesPN.width                 = 342
$updatesPN.location              = New-Object System.Drawing.Point(662,53)
$updatesPN.BackColor = "#FFEB3B"

$updDef                          = New-Object system.Windows.Forms.Button
$updDef.text                     = "Default Settings"
$updDef.width                    = 340
$updDef.height                   = 30
$updDef.location                 = New-Object System.Drawing.Point(1,1)
$updDef.Font                     = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$updLB1                          = New-Object system.Windows.Forms.Label
$updLB1.text                     = "I recommend doing security updates only."
$updLB1.AutoSize                 = $true
$updLB1.width                    = 25
$updLB1.height                   = 10
$updLB1.location                 = New-Object System.Drawing.Point(32,37)
$updLB1.Font                     = New-Object System.Drawing.Font('Microsoft Sans Serif',10,[System.Drawing.FontStyle]::Bold)

$updLB2                          = New-Object system.Windows.Forms.Label
$updLB2.text                     = "- Delays Features updates up to 3 years"
$updLB2.AutoSize                 = $true
$updLB2.width                    = 25
$updLB2.height                   = 10
$updLB2.location                 = New-Object System.Drawing.Point(33,58)
$updLB2.Font                     = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$updLB3                          = New-Object system.Windows.Forms.Label
$updLB3.text                     = "- Delays Security updates 4 days"
$updLB3.AutoSize                 = $true
$updLB3.width                    = 25
$updLB3.height                   = 10
$updLB3.location                 = New-Object System.Drawing.Point(33,79)
$updLB3.Font                     = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$updLB4                          = New-Object system.Windows.Forms.Label
$updLB4.text                     = "- Sets Maximum Active Time"
$updLB4.AutoSize                 = $true
$updLB4.width                    = 25
$updLB4.height                   = 10
$updLB4.location                 = New-Object System.Drawing.Point(33,100)
$updLB4.Font                     = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$updSec                          = New-Object system.Windows.Forms.Button
$updSec.text                     = "Security Updates Only"
$updSec.width                    = 340
$updSec.height                   = 30
$updSec.location                 = New-Object System.Drawing.Point(1,125)
$updSec.Font                     = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$updEn                           = New-Object system.Windows.Forms.Button
$updEn.text                      = "Enable Update Services"
$updEn.width                     = 340
$updEn.height                    = 30
$updEn.location                  = New-Object System.Drawing.Point(1,156)
$updEn.Font                      = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$updDisLB                        = New-Object system.Windows.Forms.Label
$updDisLB.text                   = "NOT RECOMMENDED!!!"
$updDisLB.AutoSize               = $true
$updDisLB.width                  = 25
$updDisLB.height                 = 10
$updDisLB.location               = New-Object System.Drawing.Point(85,230)
$updDisLB.Font                   = New-Object System.Drawing.Font('Microsoft Sans Serif',10,[System.Drawing.FontStyle]::Bold)

$updDis                          = New-Object system.Windows.Forms.Button
$updDis.text                     = "Disable Update Services"
$updDis.width                    = 340
$updDis.height                   = 30
$updDis.location                 = New-Object System.Drawing.Point(1,249)
$updDis.Font                     = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

#--------STATUS LOG--------
$ResultText                      = New-Object system.Windows.Forms.TextBox
$ResultText.multiline            = $true
$ResultText.width                = 342
$ResultText.height               = 150
$ResultText.location             = New-Object System.Drawing.Point(662,371)
$ResultText.Font                 = New-Object System.Drawing.Font('Microsoft Sans Serif',10)
$ResultText.ReadOnly        	 = $True
$ResultText.ScrollBars           = "2"
$ResultText.WordWrap             = $True
$ResultText.BackColor            = $colLOG

$statusLB                        = New-Object system.Windows.Forms.Label
$statusLB.text                   = "Current Status:"
$statusLB.AutoSize               = $true
$statusLB.width                  = 100
$statusLB.height                 = 20
$statusLB.location               = New-Object System.Drawing.Point(659,345)
$statusLB.Font                   = New-Object System.Drawing.Font('Calibri',15,[System.Drawing.FontStyle]::Bold)

$verLB                           = New-Object system.Windows.Forms.Label
$verLB.text                      = $ver
$verLB.AutoSize                  = $true
$verLB.width                     = 25
$verLB.height                    = 10
$verLB.location                  = New-Object System.Drawing.Point(935,355)
$verLB.Font                      = New-Object System.Drawing.Font('Calibri',8,[System.Drawing.FontStyle]::Bold)



$Form.controls.AddRange(@($choco,$installPN,$installLB,$tweaksPN,$tweaksLB,$fixesPN,$fixesLB,$ResultText,$verLB,$statusLB,$updatesPN,$winUpdLB,$line1PN,$line2PN,$line3PN,$backPN))

$installPN.controls.AddRange(@($cosmo,$bundlesLB,$essentials,$doctools,$mediatools,$consumption,$devtools,$deps,$tmpBT6,$miscLB,$openAppForm,$updChocos,$tmpBT9,$tmpBT10))

$tweaksPN.controls.AddRange(@($restorePt,$essenCfg,$UessenCfg,$cosmoCfg,$UcosmoCfg,$QoL,$UQoL,$darkMode,$UdarkMode,$perfVfx,$UperfVfx,$telem,$Utelem,$loctrack,$Uloctrack,$oneDrive,$UoneDrive,$discortana,$Udiscortana,$actionc,$Uactionc,$bgApps,$UbgApps,$utils,$Uutils,$clipbH,$UclipbH,$UTCTime,$UUTCTime))

$fixesPN.controls.AddRange(@($phoneFix,$updReset,$power,$powerCfg,$hyperV,$nfs))

$updatesPN.controls.AddRange(@($updDef,$updLB1,$updLB2,$updLB3,$updLB4,$updSec,$updEn,$updDis,$updDisLB))



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
    Install-Software gitkraken
    Install-Software nvm
})

$openAppForm.Add_Click({
    [void]$appForm.ShowDialog()
})


#--------------RUN CHOCO IN JOB--------------
$restorePt.Add_Click({
$testvar = "TEST"
    $chocoblock = {
        choco list -lo | Out-Host

        choco list -lo | Out-Host
        
        Write-Host $args[0]
        
        choco list -lo | Out-Host
        
#        choco list -lo | Out-File -FilePath 'H:\DEV\PowerShell\cosmo.WST\Results.txt'
    }

    Write-Host ("`r`nStart Job check installed chocos!`r`n")
    $installPN.Enabled = $false
    $tweaksPN.Enabled = $false
    $fixesPN.Enabled = $false
    $updatesPN.Enabled = $false


    #-------Waits for the Job and then outputs log
#    Start-Job -ScriptBlock $chocoblock -Name "bgchocojob" | Wait-Job | Receive-Job


    #-------Starts Job and checks per while loop
    
#    Start-Job -ScriptBlock { Write-Host $input } -InputObject $testvar -Name "bgchocojob"
    Start-Job -ScriptBlock $chocoblock -ArgumentList $testvar -Name "bgchocojob"
#    Start-Job -ScriptBlock $chocoblock -Name "bgchocojob"
    
    do {
#        Write-Host ("Process Stopping VM!`r`n")
        [System.Windows.Forms.Application]::DoEvents()
#        Start-Sleep -Seconds 1
        Start-Sleep -Milliseconds 200
        Receive-Job -Name "bgchocojob"
        }
    while ((Get-Job -Name "bgchocojob").State -ne 'Completed')


    Write-Host ("Process Completed!`r`n")
    $installPN.Enabled = $True
    $tweaksPN.Enabled = $True
    $fixesPN.Enabled = $True
    $updatesPN.Enabled = $True
    #------Save Job info in txt
#    Get-job -Name "bgchocojob" | Format-List | Out-File -FilePath 'H:\DEV\PowerShell\cosmo.WST\Results.txt'
#    $ResultText.AppendText((Get-Content -Path 'H:\DEV\PowerShell\cosmo.WST\Results.txt' | Out-String -Width 1000))

})


#--------------SHOW CHOCO IN CONSOLE--------------
$QoL.Add_Click({
        choco list -lo | Out-Default
        choco list -lo | Out-Host
        choco list -lo | Out-Host
})


#--------------SHOW CONSOLE WHILE CHOCO--------------
$sig = '
[DllImport("user32.dll")] public static extern bool ShowWindowAsync(IntPtr hWnd, int nCmdShow);
[DllImport("user32.dll")] public static extern int SetForegroundWindow(IntPtr hwnd);
[DllImport("kernel32.dll")] public static extern IntPtr GetConsoleWindow();'

$type = Add-Type -MemberDefinition $sig -Name WindowAPI -PassThru

$essenCfg.Add_Click({
    # Get this form's window handle.
    $handleForm = $Form.Handle # More generically: $this.FindForm().Handle
    # Get the console window's handle.
    $handleConsole = $type::GetConsoleWindow()
    # Activate the console window and prompt the user.
    $null = $type::ShowWindowAsync($handleConsole, 4); $null = $type::SetForegroundWindow($handleConsole)
#    Read-Host -Prompt "Please Enter a Value"
    choco list -lo | Out-Host
    choco list -lo | Out-Host
    # Reactivate this form.
    $null = $type::ShowWindowAsync($handleForm, 4); $null = $type::SetForegroundWindow($handleForm)
  
})

$UessenCfg.Add_Click({
    $lol = Char.ConvertFromUtf16(2022)
    
    Write-Host $lol
})



#--------------------FUNCTIONS--------------------

#--------LOGGER FX--------
function Write-Log{
    $LogMsg = $args[0]
    Write-Host $LogMsg
    $ResultText.AppendText("`r`n"+$LogMsg)
}

function Install-Software{
    $AppName = $args[0]
    Write-Log ("`r`n" + "Installing " + $AppName)
    Write-Log ("...Please Wait")
    choco install $AppName -y -r
    Write-Log ("Finished Installing " + $AppName)
    Write-Log (" >>> Ready for Next Task")
}


#--------------------SCRIPT EXECUTION--------------------
#--------CHOCOLATEY CHECK--------
Write-Host "Checking Choco..."

if (Test-Path C:\ProgramData\chocolatey\choco.exe){
    'Choco Already Installed'
    $ResultText.text = "Chocolatey Already Installed"
    $installPN.Enabled = $True
    $choco.Enabled = $false
}  
else{
    
	Write-Host "Choco not found"
    $ResultText.text = "`r`n" + "Chocolatey not found..." + "`r`n" +  "Please install Chocolatey first!!!"

}

#--------SHOW GUI--------
[void]$Form.ShowDialog()

Start-Sleep -Seconds 1

[void]$Form.Focus()