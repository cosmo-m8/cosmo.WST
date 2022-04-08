#--------------------GUI SPECS--------------------
$Form                            = New-Object system.Windows.Forms.Form
$Form.ClientSize                 = New-Object System.Drawing.Point(1050,400)
$Form.text                       = "cosmo.WST • Windows Setup Toolbox by cosmo"
$Form.StartPosition              = "CenterScreen"
$Form.TopMost                    = $false
$Form.BackColor                  = [System.Drawing.ColorTranslator]::FromHtml("#e9e9e9")
$Form.AutoScaleDimensions     = '192, 192'
$Form.AutoScaleMode           = "Dpi"
$Form.AutoSize                = $True
$Form.AutoScroll              = $True
$Form.FormBorderStyle         = 'FixedSingle'
$Form.MaximumSize             = New-Object System.Drawing.Size($MaxWid, $MaxHei)

$Form.Icon                    = [System.Drawing.Icon]::FromHandle((New-Object System.Drawing.Bitmap -Argument $stream).GetHIcon())

#--------------------GUI ELEMENTS--------------------
#--------STATUS INFO--------
$ResultText                      = New-Object system.Windows.Forms.TextBox
$ResultText.multiline            = $true
$ResultText.width                = 350
$ResultText.height               = 130
$ResultText.location             = New-Object System.Drawing.Point(700,391)
$ResultText.Font                 = New-Object System.Drawing.Font('Microsoft Sans Serif',10)
$ResultText.ReadOnly        	 = $True
$ResultText.ScrollBars           = "2"
$ResultText.WordWrap             = $True

#--------INSTALL SECTION--------
$installLB                       = New-Object system.Windows.Forms.Label
$installLB.text                  = "Install"
$installLB.AutoSize              = $true
$installLB.width                 = 152
$installLB.height                = 25
$installLB.location              = New-Object System.Drawing.Point(34,10)
$installLB.Font                  = New-Object System.Drawing.Font('Calibri',24, [System.Drawing.FontStyle]::Bold)

$choco                           = New-Object system.Windows.Forms.Button
$choco.text                      = "Chocolatey"
$choco.width                     = 150
$choco.height                    = 30
$choco.location                  = New-Object System.Drawing.Point(7,54)
$choco.Font                      = New-Object System.Drawing.Font('Microsoft Sans Serif',12)
$choco.BackColor = "#1F88E4"

$installPN                       = New-Object system.Windows.Forms.Panel
$installPN.height                = 469
$installPN.width                 = 152
$installPN.location              = New-Object System.Drawing.Point(6,53)
#$installPN.BackColor = "#9E3636"
$installPN.Enabled = $false

$bundlesLB                       = New-Object system.Windows.Forms.Label
$bundlesLB.text                  = "Bundles:"
$bundlesLB.AutoSize              = $true
$bundlesLB.width                 = 25
$bundlesLB.height                = 10
$bundlesLB.location              = New-Object System.Drawing.Point(0,43)
$bundlesLB.Font                  = New-Object System.Drawing.Font('Microsoft Sans Serif',10,[System.Drawing.FontStyle]([System.Drawing.FontStyle]::Bold))

$cosmo                           = New-Object system.Windows.Forms.Button
$cosmo.text                      = "cosmoPack"
$cosmo.width                     = 150
$cosmo.height                    = 30
$cosmo.location                  = New-Object System.Drawing.Point(1,63)
$cosmo.Font                      = New-Object System.Drawing.Font('Microsoft Sans Serif',12)
$cosmo.BackColor                 = "#7E57C2"
$instTT.SetToolTip($cosmo, "7-Zip`r`nVLC`r`n---`r`nSumatra PDF`r`nLibreOffice`r`n---`r`nGoogle Chrome`r`nGoogle Drive`r`n---`r`nGIMP`r`nVSCode`r`nNotepad++`r`nWindows Terminal")

$essentials                      = New-Object system.Windows.Forms.Button
$essentials.text                 = "Essentials"
$essentials.width                = 150
$essentials.height               = 30
$essentials.location             = New-Object System.Drawing.Point(1,94)
$essentials.Font                 = New-Object System.Drawing.Font('Microsoft Sans Serif',12)
$instTT.SetToolTip($essentials, "7-Zip`r`nVLC`r`n---`r`nSumatra PDF`r`nLibreOffice`r`n---`r`nGoogle Chrome")

$tmpBT1                          = New-Object system.Windows.Forms.Button
$tmpBT1.text                     = "tmpBT1"
$tmpBT1.width                    = 150
$tmpBT1.height                   = 30
$tmpBT1.location                 = New-Object System.Drawing.Point(1,125)
$tmpBT1.Font                     = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$tmpBT2                            = New-Object system.Windows.Forms.Button
$tmpBT2.text                       = "tmpBT2"
$tmpBT2.width                      = 150
$tmpBT2.height                     = 30
$tmpBT2.location                   = New-Object System.Drawing.Point(1,156)
$tmpBT2.Font                       = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$tmpBT3                         = New-Object system.Windows.Forms.Button
$tmpBT3.text                    = "tmpBT3"
$tmpBT3.width                   = 150
$tmpBT3.height                  = 30
$tmpBT3.location                = New-Object System.Drawing.Point(1,187)
$tmpBT3.Font                    = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$tmpBT4                           = New-Object system.Windows.Forms.Button
$tmpBT4.text                      = "tmpBT4"
$tmpBT4.width                     = 150
$tmpBT4.height                    = 30
$tmpBT4.location                  = New-Object System.Drawing.Point(1,218)
$tmpBT4.Font                      = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$tmpBT5                          = New-Object system.Windows.Forms.Button
$tmpBT5.text                     = "tmpBT5"
$tmpBT5.width                    = 150
$tmpBT5.height                   = 30
$tmpBT5.location                 = New-Object System.Drawing.Point(1,249)
$tmpBT5.Font                     = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$tmpBT6                          = New-Object system.Windows.Forms.Button
$tmpBT6.text                     = "tmpBT6"
$tmpBT6.width                    = 150
$tmpBT6.height                   = 30
$tmpBT6.location                 = New-Object System.Drawing.Point(1,280)
$tmpBT6.Font                     = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$miscLB                          = New-Object system.Windows.Forms.Label
$miscLB.text                     = "Miscellaneous:"
$miscLB.AutoSize                 = $true
$miscLB.width                    = 25
$miscLB.height                   = 10
$miscLB.location                 = New-Object System.Drawing.Point(0,322)
$miscLB.Font                     = New-Object System.Drawing.Font('Microsoft Sans Serif',10,[System.Drawing.FontStyle]([System.Drawing.FontStyle]::Bold))

$openAppForm                           = New-Object system.Windows.Forms.Button
$openAppForm.text                      = "App Installer"
$openAppForm.width                     = 150
$openAppForm.height                    = 30
$openAppForm.location                  = New-Object System.Drawing.Point(1,342)
$openAppForm.Font                      = New-Object System.Drawing.Font('Microsoft Sans Serif',12)
$genTT.SetToolTip($openAppForm, "Opens menu for installing`r`nindividual Software")

$updChocos                       = New-Object system.Windows.Forms.Button
$updChocos.text                  = "Update All"
$updChocos.width                 = 150
$updChocos.height                = 30
$updChocos.location              = New-Object System.Drawing.Point(1,373)
$updChocos.Font                  = New-Object System.Drawing.Font('Microsoft Sans Serif',12)
$genTT.SetToolTip($updChocos, "Updates any Software`r`ninstalled with Chocolatey")

$tmpBT9                         = New-Object system.Windows.Forms.Button
$tmpBT9.text                    = "tmpBT9"
$tmpBT9.width                   = 150
$tmpBT9.height                  = 30
$tmpBT9.location                = New-Object System.Drawing.Point(1,404)
$tmpBT9.Font                    = New-Object System.Drawing.Font('Microsoft Sans Serif',12)
$tmpBT9.Enabled = $false

$tmpBT10                        = New-Object system.Windows.Forms.Button
$tmpBT10.text                   = "tmpBT10"
$tmpBT10.width                  = 150
$tmpBT10.height                 = 30
$tmpBT10.location               = New-Object System.Drawing.Point(1,435)
$tmpBT10.Font                   = New-Object System.Drawing.Font('Microsoft Sans Serif',12)
$tmpBT10.Enabled = $false

#--------SEPERATOR--------
$line1PN                          = New-Object system.Windows.Forms.Panel
$line1PN.height                   = 508
$line1PN.width                    = 2
$line1PN.location                 = New-Object System.Drawing.Point(173,10)
$line1PN.BackColor = "#BDBDBD"

#--------TWEAKS SECTION--------
$tweaksLB                          = New-Object system.Windows.Forms.Label
$tweaksLB.text                     = "Tweaks"
$tweaksLB.AutoSize                 = $true
$tweaksLB.width                    = 100
$tweaksLB.height                   = 25
$tweaksLB.location                 = New-Object System.Drawing.Point(235,10)
$tweaksLB.Font                     = New-Object System.Drawing.Font('Calibri',24, [System.Drawing.FontStyle]::Bold)

$tweaksPN                          = New-Object system.Windows.Forms.Panel
$tweaksPN.height                   = 469
$tweaksPN.width                    = 202
$tweaksPN.location                 = New-Object System.Drawing.Point(190,53)
#$tweaksPN.BackColor = "#4EC5F1"

$restorePt                          = New-Object system.Windows.Forms.Button
$restorePt.text                     = "System Restore Point"
$restorePt.width                    = 200
$restorePt.height                   = 30
$restorePt.location                 = New-Object System.Drawing.Point(1,1)
$restorePt.Font                     = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$essenCfg                          = New-Object system.Windows.Forms.Button
$essenCfg.text                     = "Essential Tweaks"
$essenCfg.width                    = 150
$essenCfg.height                   = 30
$essenCfg.location                 = New-Object System.Drawing.Point(1,32)
$essenCfg.Font                     = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$UessenCfg                          = New-Object system.Windows.Forms.Button
$UessenCfg.text                     = "Undo"
$UessenCfg.width                    = 49
$UessenCfg.height                   = 30
$UessenCfg.location                 = New-Object System.Drawing.Point(152,32)
$UessenCfg.Font                     = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$cosmoCfg                          = New-Object system.Windows.Forms.Button
$cosmoCfg.text                     = "cosmoConfig"
$cosmoCfg.width                    = 150
$cosmoCfg.height                   = 30
$cosmoCfg.location                 = New-Object System.Drawing.Point(1,63)
$cosmoCfg.Font                     = New-Object System.Drawing.Font('Microsoft Sans Serif',12)
$cosmoCfg.BackColor                = "#7E57C2"
$genTT.SetToolTip($cosmoCfg, "• System Restore Point`r`n• Quality of Life`r`n• Dark Mode`r`n• Disable Telemetry`r`n• Disable Location Tracking`r`n• Delete OneDrive`r`n• Disable Hibernation`r`n• Enable UTC-Time")

$darkMode                          = New-Object system.Windows.Forms.Button
$darkMode.text                     = "Dark Mode"
$darkMode.width                    = 150
$darkMode.height                   = 30
$darkMode.location                 = New-Object System.Drawing.Point(1,94)
$darkMode.Font                     = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$perfVfx                          = New-Object system.Windows.Forms.Button
$perfVfx.text                     = "Performance VFX"
$perfVfx.width                    = 150
$perfVfx.height                   = 30
$perfVfx.location                 = New-Object System.Drawing.Point(1,125)
$perfVfx.Font                     = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

#--------SEPERATOR--------
$line2PN                          = New-Object system.Windows.Forms.Panel
$line2PN.height                   = 508
$line2PN.width                    = 2
$line2PN.location                 = New-Object System.Drawing.Point(407,10)
$line2PN.BackColor = "#BDBDBD"

#--------FIXES/TOOLS SECTION--------
$fixesPN                          = New-Object system.Windows.Forms.Panel
$fixesPN.height                   = 381
$fixesPN.width                    = 220
$fixesPN.location                 = New-Object System.Drawing.Point(464,53)
$fixesPN.BackColor = "#7400ad"

#--------WIN UPDATE SECTION--------
$updatesPN                          = New-Object system.Windows.Forms.Panel
$updatesPN.height                   = 328
$updatesPN.width                    = 340
$updatesPN.location                 = New-Object System.Drawing.Point(699,53)
$updatesPN.BackColor = "#adad00"



$Form.controls.AddRange(@($choco,$installPN,$installLB,$tweaksPN,$tweaksLB,$updatesPN,$fixesPN,$ResultText,$line1PN,$line2PN))

$installPN.controls.AddRange(@($cosmo,$bundlesLB,$essentials,$tmpBT1,$tmpBT2,$tmpBT3,$tmpBT4,$tmpBT5,$tmpBT6,$miscLB,$openAppForm,$updChocos,$tmpBT9,$tmpBT10))

$tweaksPN.controls.AddRange(@($restorePt,$essenCfg,$UessenCfg,$cosmoCfg,$darkMode,$perfVfx))

