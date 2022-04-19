Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.Application]::EnableVisualStyles()

#--------------------GET ADMIN PRIVILEGE--------------------
<#
$ErrorActionPreference = 'SilentlyContinue'
$wshell = New-Object -ComObject Wscript.Shell
$Button = [System.Windows.MessageBoxButton]::YesNoCancel
$ErrorIco = [System.Windows.MessageBoxImage]::Error
If (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]'Administrator')) {
	Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
	Exit
}
#>


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