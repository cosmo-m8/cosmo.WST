$ErrorActionPreference = 'SilentlyContinue'
$wshell = New-Object -ComObject Wscript.Shell
$Button = [System.Windows.MessageBoxButton]::YesNoCancel
$ErrorIco = [System.Windows.MessageBoxImage]::Error
If (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]'Administrator')) {
	Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
	Exit
}


# DOT SOURCING INIT
. "$PSScriptRoot\source\cosmo.WST_1-Init.ps1"


# DOT SOURCING GUI ICON BASE-64
. "$PSScriptRoot\source\cosmo.WST_2-Icon.ps1"


# DOT SOURCING MAIN GUI SPECS
. "$PSScriptRoot\source\cosmo.WST_3-Form.ps1"


# DOT SOURCING APP-INSTALL GUI SPECS
. "$PSScriptRoot\source\cosmo.WST_4-appForm.ps1"


# DOT SOURCING MAIN BUTTON CLICKS
. "$PSScriptRoot\source\cosmo.WST_5-Clicks.ps1"


# DOT SOURCING INSTALL BUTTON CLICKS
. "$PSScriptRoot\source\cosmo.WST_6-appClicks.ps1"


# DOT SOURCING FUNCTIONS
. "$PSScriptRoot\source\cosmo.WST_7-Functs.ps1"


# DOT SOURCING SCRIPT EXECUTION
. "$PSScriptRoot\source\cosmo.WST_8-Exec.ps1"