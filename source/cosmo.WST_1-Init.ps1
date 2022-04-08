Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.Application]::EnableVisualStyles()

#--------------------MAX FRAME SIZE CHECK--------------------
$MaxWid = [System.Windows.Forms.Screen]::PrimaryScreen.WorkingArea.Width
$MaxHei = [System.Windows.Forms.Screen]::PrimaryScreen.WorkingArea.Height

Write-Host "Maximum Form Size:" $MaxWid "x" $MaxHei
Write-Host "----------------------------------------"

#--------------------GET ADMIN PRIVILEGE--------------------


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