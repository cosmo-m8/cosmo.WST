#--------------------APP GUI SPECS--------------------
$appForm                            = New-Object system.Windows.Forms.Form
$appForm.ClientSize                 = New-Object System.Drawing.Point(1050,400)
$appForm.text                       = "cosmo.WST • Software Selection"
$appForm.StartPosition              = "CenterScreen"
$appForm.TopMost                    = $false
$appForm.BackColor                  = [System.Drawing.ColorTranslator]::FromHtml("#e9e9e9")
$appForm.AutoScaleDimensions     = '192, 192'
$appForm.AutoScaleMode           = "Dpi"
$appForm.AutoSize                = $True
$appForm.AutoScroll              = $True
$appForm.FormBorderStyle         = 'FixedSingle'
$appForm.MaximumSize             = New-Object System.Drawing.Size($MaxWid, $MaxHei)

$appForm.Icon                    = [System.Drawing.Icon]::FromHandle((New-Object System.Drawing.Bitmap -Argument $stream).GetHIcon())

#--------------------APP GUI ELEMENTS--------------------
<#
$ResultText                      = New-Object system.Windows.Forms.TextBox
$ResultText.multiline            = $true
$ResultText.width                = 350
$ResultText.height               = 130
$ResultText.location             = New-Object System.Drawing.Point(700,391)
$ResultText.Font                 = New-Object System.Drawing.Font('Microsoft Sans Serif',10)
$ResultText.ReadOnly        	 = $True
$ResultText.ScrollBars           = "2"
$ResultText.WordWrap             = $True

$Label1                          = New-Object system.Windows.Forms.Label
$Label1.text                     = "Install"
$Label1.AutoSize                 = $true
$Label1.width                    = 230
$Label1.height                   = 25
$Label1.location                 = New-Object System.Drawing.Point(34,11)
$Label1.Font                     = New-Object System.Drawing.Font('Calibri',24, [System.Drawing.FontStyle]::Bold)

$choco                           = New-Object system.Windows.Forms.Button
$choco.text                      = "Chocolatey"
$choco.width                     = 150
$choco.height                    = 30
$choco.location                  = New-Object System.Drawing.Point(7,55)
$choco.Font                      = New-Object System.Drawing.Font('Microsoft Sans Serif',12)
$choco.BackColor = "#1F88E4"

$Panel1                          = New-Object system.Windows.Forms.Panel
$Panel1.height                   = 400
$Panel1.width                    = 219
$Panel1.location                 = New-Object System.Drawing.Point(6,54)
$Panel1.BackColor = "#9E3636"
$Panel1.Enabled = $false

$Label2                          = New-Object system.Windows.Forms.Label
$Label2.text                     = "Bundles:"
$Label2.AutoSize                 = $true
$Label2.width                    = 25
$Label2.height                   = 10
$Label2.location                 = New-Object System.Drawing.Point(0,35)
$Label2.Font                     = New-Object System.Drawing.Font('Microsoft Sans Serif',10,[System.Drawing.FontStyle]([System.Drawing.FontStyle]::Bold))

$cosmo                           = New-Object system.Windows.Forms.Button
$cosmo.text                      = "cosmoPack"
$cosmo.width                     = 150
$cosmo.height                    = 30
$cosmo.location                  = New-Object System.Drawing.Point(0,50)
$cosmo.Font                      = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$essentials                      = New-Object system.Windows.Forms.Button
$essentials.text                 = "Essentials"
$essentials.width                = 150
$essentials.height               = 30
$essentials.location             = New-Object System.Drawing.Point(0,80)
$essentials.Font                 = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$Label3                          = New-Object system.Windows.Forms.Label
$Label3.text                     = "Applications:"
$Label3.AutoSize                 = $true
$Label3.width                    = 25
$Label3.height                   = 10
$Label3.location                 = New-Object System.Drawing.Point(0,115)
$Label3.Font                     = New-Object System.Drawing.Font('Microsoft Sans Serif',10,[System.Drawing.FontStyle]([System.Drawing.FontStyle]::Bold))

$fzilla                          = New-Object system.Windows.Forms.Button
$fzilla.text                     = "FileZilla"
$fzilla.width                    = 150
$fzilla.height                   = 30
$fzilla.location                 = New-Object System.Drawing.Point(0,130)
$fzilla.Font                     = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$vbox                            = New-Object system.Windows.Forms.Button
$vbox.text                       = "VirtualBox"
$vbox.width                      = 150
$vbox.height                     = 30
$vbox.location                   = New-Object System.Drawing.Point(0,160)
$vbox.Font                       = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$audcity                         = New-Object system.Windows.Forms.Button
$audcity.text                    = "AudaCity"
$audcity.width                   = 150
$audcity.height                  = 30
$audcity.location                = New-Object System.Drawing.Point(0,190)
$audcity.Font                    = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$steam                           = New-Object system.Windows.Forms.Button
$steam.text                      = "Steam"
$steam.width                     = 150
$steam.height                    = 30
$steam.location                  = New-Object System.Drawing.Point(0,220)
$steam.Font                      = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$itunes                          = New-Object system.Windows.Forms.Button
$itunes.text                     = "iTunes"
$itunes.width                    = 150
$itunes.height                   = 30
$itunes.location                 = New-Object System.Drawing.Point(0,250)
$itunes.Font                     = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$icloud                          = New-Object system.Windows.Forms.Button
$icloud.text                     = "VirtualBox"
$icloud.width                    = 150
$icloud.height                   = 30
$icloud.location                 = New-Object System.Drawing.Point(0,280)
$icloud.Font                     = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$keepass                         = New-Object system.Windows.Forms.Button
$keepass.text                    = "KeePass"
$keepass.width                   = 150
$keepass.height                  = 30
$keepass.location                = New-Object System.Drawing.Point(0,310)
$keepass.Font                    = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$parsec                          = New-Object system.Windows.Forms.Button
$parsec.text                     = "Parsec"
$parsec.width                    = 150
$parsec.height                   = 30
$parsec.location                 = New-Object System.Drawing.Point(0,340)
$parsec.Font                     = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$tviewer                         = New-Object system.Windows.Forms.Button
$tviewer.text                    = "TeamViewer"
$tviewer.width                   = 150
$tviewer.height                  = 30
$tviewer.location                = New-Object System.Drawing.Point(0,300)
$tviewer.Font                    = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$chocogui                        = New-Object system.Windows.Forms.Button
$chocogui.text                   = "ChocolateyGUI"
$chocogui.width                  = 150
$chocogui.height                 = 30
$chocogui.location               = New-Object System.Drawing.Point(0,330)
$chocogui.Font                   = New-Object System.Drawing.Font('Microsoft Sans Serif',12)


$Label4                          = New-Object system.Windows.Forms.Label
$Label4.text                     = "System Tweaks"
$Label4.AutoSize                 = $true
$Label4.width                    = 230
$Label4.height                   = 25
$Label4.location                 = New-Object System.Drawing.Point(349,11)
$Label4.Font                     = New-Object System.Drawing.Font('Microsoft Sans Serif',24)

$Panel2                          = New-Object system.Windows.Forms.Panel
$Panel2.height                   = 400
$Panel2.width                    = 211
$Panel2.location                 = New-Object System.Drawing.Point(240,54)


$Panel3                          = New-Object system.Windows.Forms.Panel
$Panel3.height                   = 381
$Panel3.width                    = 220
$Panel3.location                 = New-Object System.Drawing.Point(464,54)


$Panel4                          = New-Object system.Windows.Forms.Panel
$Panel4.height                   = 328
$Panel4.width                    = 340
$Panel4.location                 = New-Object System.Drawing.Point(699,54)

# FORM TOOLTIPS
$instTT                          = New-Object System.Windows.Forms.ToolTip
$instTT.AutoPopDelay             = 32000
$instTT.InitialDelay             = 200
$instTT.ReshowDelay              = 100
$instTT.ShowAlways               = $True
$instTT.ToolTipIcon              = "Warning"
$instTT.ToolTipTitle             = "INSTALLS:"
$instTT.SetToolTip($cosmo, "7-Zip`r`nVLC`r`n---`r`nSumatra PDF`r`nLibreOffice`r`n---`r`nGoogle Chrome`r`nGoogle Drive`r`n---`r`nGIMP`r`nVSCode`r`nNotepad++`r`nWindows Terminal")
$instTT.SetToolTip($essentials, "7-Zip`r`nVLC`r`n---`r`nSumatra PDF`r`nLibreOffice`r`n---`r`nGoogle Chrome")

$genTT                           = New-Object System.Windows.Forms.ToolTip
$genTT.AutoPopDelay              = 32000
$genTT.InitialDelay              = 300
$genTT.ReshowDelay               = 100
$genTT.ShowAlways                = $True
$genTT.ToolTipIcon               = "Info"
$genTT.ToolTipTitle              = "More Info:"
#$genTT.SetToolTip($cosmo, "TEST")

$appForm.controls.AddRange(@($Label1,$choco,$Panel1,$Label4,$Panel4,$Panel3,$ResultText))

$Panel1.controls.AddRange(@($cosmo,$Label2,$essentials,$fzilla,$Label3,$vbox,$audcity,$steam,$itunes,$icloud,$keepass,$parsec,$tviewer,$chocogui))
#>
