#--------------------APP GUI SPECS--------------------
$appForm                            = New-Object system.Windows.Forms.Form
$appForm.ClientSize                 = New-Object System.Drawing.Point(1050,400)
$appForm.text                       = "         [   cosmo.WST   ]         |      Software Installation Menu"
$appForm.StartPosition              = "CenterScreen"
$appForm.TopMost                    = $false
$appForm.BackColor                  = [System.Drawing.ColorTranslator]::FromHtml($colBG)
$appForm.AutoScaleDimensions     = '192, 192'
$appForm.AutoScaleMode           = "Dpi"
$appForm.AutoSize                = $True
$appForm.AutoScroll              = $True
$appForm.FormBorderStyle         = 'FixedSingle'
$appForm.MaximumSize             = New-Object System.Drawing.Size($MaxWid, $MaxHei)

$appForm.Icon                    = [System.Drawing.Icon]::FromHandle((New-Object System.Drawing.Bitmap -Argument $stream).GetHIcon())

#--------------------APP GUI ELEMENTS--------------------
$appFormPN                          = New-Object system.Windows.Forms.Panel
$appFormPN.height                   = 300
$appFormPN.width                    = 510
$appFormPN.location                 = New-Object System.Drawing.Point(20,53)
#$appFormPN.BackColor = "#9E3636"

$appFormLB                          = New-Object system.Windows.Forms.Label
$appFormLB.text                     = "Software Installation Menu"
$appFormLB.AutoSize                 = $true
$appFormLB.width                    = 230
$appFormLB.height                   = 25
$appFormLB.location                 = New-Object System.Drawing.Point(80,11)
$appFormLB.Font                     = New-Object System.Drawing.Font('Calibri',24, [System.Drawing.FontStyle]::Bold)

$utilsLB                          = New-Object system.Windows.Forms.Label
$utilsLB.text                     = "Utilities:"
$utilsLB.AutoSize                 = $true
$utilsLB.width                    = 25
$utilsLB.height                   = 10
$utilsLB.location                 = New-Object System.Drawing.Point(0,12)
$utilsLB.Font                     = New-Object System.Drawing.Font('Microsoft Sans Serif',10,[System.Drawing.FontStyle]([System.Drawing.FontStyle]::Bold))

$fzilla                          = New-Object system.Windows.Forms.Button
$fzilla.text                     = "FileZilla"
$fzilla.width                    = 150
$fzilla.height                   = 30
$fzilla.location                 = New-Object System.Drawing.Point(0,32)
$fzilla.Font                     = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$parsec                          = New-Object system.Windows.Forms.Button
$parsec.text                     = "Parsec"
$parsec.width                    = 150
$parsec.height                   = 30
$parsec.location                 = New-Object System.Drawing.Point(0,63)
$parsec.Font                     = New-Object System.Drawing.Font('Microsoft Sans Serif',12)



$docappsLB                          = New-Object system.Windows.Forms.Label
$docappsLB.text                     = "Document Tools:"
$docappsLB.AutoSize                 = $true
$docappsLB.width                    = 25
$docappsLB.height                   = 10
$docappsLB.location                 = New-Object System.Drawing.Point(170,12)
$docappsLB.Font                     = New-Object System.Drawing.Font('Microsoft Sans Serif',10,[System.Drawing.FontStyle]([System.Drawing.FontStyle]::Bold))

$vbox                            = New-Object system.Windows.Forms.Button
$vbox.text                       = "VirtualBox"
$vbox.width                      = 150
$vbox.height                     = 30
$vbox.location                   = New-Object System.Drawing.Point(170,32)
$vbox.Font                       = New-Object System.Drawing.Font('Microsoft Sans Serif',12)




$mediaappsLB                          = New-Object system.Windows.Forms.Label
$mediaappsLB.text                     = "Media Tools:"
$mediaappsLB.AutoSize                 = $true
$mediaappsLB.width                    = 25
$mediaappsLB.height                   = 10
$mediaappsLB.location                 = New-Object System.Drawing.Point(340,12)
$mediaappsLB.Font                     = New-Object System.Drawing.Font('Microsoft Sans Serif',10,[System.Drawing.FontStyle]([System.Drawing.FontStyle]::Bold))

$vlc                            = New-Object system.Windows.Forms.Button
$vlc.text                       = "VLC Media Player"
$vlc.width                      = 150
$vlc.height                     = 30
$vlc.location                   = New-Object System.Drawing.Point(340,32)
$vlc.Font                       = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

<#
#--------SEPERATOR--------
$line1PN                         = New-Object system.Windows.Forms.Panel
$line1PN.height                  = 508
$line1PN.width                   = 2
$line1PN.location                = New-Object System.Drawing.Point(177,10)
$line1PN.BackColor               = $colSEP
#>


$appForm.controls.AddRange(@($appFormPN,$appFormLB))

$appFormPN.controls.AddRange(@($fzilla,$utilsLB,$parsec,$vbox,$docappsLB,$vlc,$mediaappsLB))