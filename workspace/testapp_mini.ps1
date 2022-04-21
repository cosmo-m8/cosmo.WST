Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.Application]::EnableVisualStyles()

Add-Type -AssemblyName PresentationFramework




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


#--------------------GUI SPECS--------------------
$Form                            = New-Object system.Windows.Forms.Form
$Form.ClientSize                 = New-Object System.Drawing.Point(1050,400)
$Form.text                       = "cosmo.WST • Windows Setup Toolbox by cosmo"
$Form.StartPosition              = "CenterScreen"
$Form.TopMost                    = $false
$Form.BackColor                  = [System.Drawing.ColorTranslator]::FromHtml($colBG)
$Form.AutoScaleDimensions     = '192, 192'
$Form.AutoScaleMode           = "Dpi"
$Form.AutoSize                = $True
$Form.AutoScroll              = $True
$Form.FormBorderStyle         = 'FixedSingle'
#$Form.MaximumSize             = New-Object System.Drawing.Size($MaxWid, $MaxHei)


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
$choco.text                      = "DL!-1"
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
#$installPN.Enabled = $false

$bundlesLB                       = New-Object system.Windows.Forms.Label
$bundlesLB.text                  = "Bundles:"
$bundlesLB.AutoSize              = $true
$bundlesLB.width                 = 25
$bundlesLB.height                = 10
$bundlesLB.location              = New-Object System.Drawing.Point(0,43)
$bundlesLB.Font                  = New-Object System.Drawing.Font('Microsoft Sans Serif',10,[System.Drawing.FontStyle]::Bold)

$DLnameGet                           = New-Object system.Windows.Forms.Button
$DLnameGet.text                      = "DL!-2?"
$DLnameGet.width                     = 150
$DLnameGet.height                    = 30
$DLnameGet.location                  = New-Object System.Drawing.Point(1,63)
$DLnameGet.Font                      = New-Object System.Drawing.Font('Microsoft Sans Serif',12)
$DLnameGet.BackColor                 = $colcosmo

$essentials                      = New-Object system.Windows.Forms.Button
$essentials.text                 = "Essentials"
$essentials.width                = 150
$essentials.height               = 30
$essentials.location             = New-Object System.Drawing.Point(1,94)
$essentials.Font                 = New-Object System.Drawing.Font('Microsoft Sans Serif',12)
$essentials.BackColor            = $col1

$doctools                        = New-Object system.Windows.Forms.Button
$doctools.text                   = "Document Tools"
$doctools.width                  = 150
$doctools.height                 = 30
$doctools.location               = New-Object System.Drawing.Point(1,125)
$doctools.Font                   = New-Object System.Drawing.Font('Microsoft Sans Serif',12)
$doctools.BackColor              = $colBT

$mediatools                      = New-Object system.Windows.Forms.Button
$mediatools.text                 = "Media Tools"
$mediatools.width                = 150
$mediatools.height               = 30
$mediatools.location             = New-Object System.Drawing.Point(1,156)
$mediatools.Font                 = New-Object System.Drawing.Font('Microsoft Sans Serif',12)
$mediatools.BackColor            = $colBT

$consumption                     = New-Object system.Windows.Forms.Button
$consumption.text                = "Consumption"
$consumption.width               = 150
$consumption.height              = 30
$consumption.location            = New-Object System.Drawing.Point(1,187)
$consumption.Font                = New-Object System.Drawing.Font('Microsoft Sans Serif',12)
$consumption.BackColor           = $colBT

$devtools                        = New-Object system.Windows.Forms.Button
$devtools.text                   = "Development"
$devtools.width                  = 150
$devtools.height                 = 30
$devtools.location               = New-Object System.Drawing.Point(1,218)
$devtools.Font                   = New-Object System.Drawing.Font('Microsoft Sans Serif',12)
$devtools.BackColor              = $colBT

$deps                            = New-Object system.Windows.Forms.Button
$deps.text                       = "Dependencies"
$deps.width                      = 150
$deps.height                     = 30
$deps.location                   = New-Object System.Drawing.Point(1,249)
$deps.Font                       = New-Object System.Drawing.Font('Microsoft Sans Serif',12)
$deps.BackColor                  = $colBT

$tmpBT6                          = New-Object system.Windows.Forms.Button
$tmpBT6.text                     = "comming soon"
$tmpBT6.width                    = 150
$tmpBT6.height                   = 30
$tmpBT6.location                 = New-Object System.Drawing.Point(1,280)
$tmpBT6.Font                     = New-Object System.Drawing.Font('Microsoft Sans Serif',12)
$tmpBT6.BackColor                = $colBT
#$tmpBT6.Enabled = $false

$miscLB                          = New-Object system.Windows.Forms.Label
$miscLB.text                     = "Miscellaneous:"
$miscLB.AutoSize                 = $true
$miscLB.width                    = 25
$miscLB.height                   = 10
$miscLB.location                 = New-Object System.Drawing.Point(0,322)
$miscLB.Font                     = New-Object System.Drawing.Font('Microsoft Sans Serif',10,[System.Drawing.FontStyle]([System.Drawing.FontStyle]::Bold))

$DLzip                     = New-Object system.Windows.Forms.Button
$DLzip.text                = "DL!+unZIP!"
$DLzip.width               = 150
$DLzip.height              = 30
$DLzip.location            = New-Object System.Drawing.Point(1,342)
$DLzip.Font                = New-Object System.Drawing.Font('Microsoft Sans Serif',12)
$DLzip.BackColor           = $colBT

$updChocos                       = New-Object system.Windows.Forms.Button
$updChocos.text                  = "Restart PC#1"
$updChocos.width                 = 150
$updChocos.height                = 30
$updChocos.location              = New-Object System.Drawing.Point(1,373)
$updChocos.Font                  = New-Object System.Drawing.Font('Microsoft Sans Serif',12)
$updChocos.BackColor             = $colBT

$DLWebClient                          = New-Object system.Windows.Forms.Button
$DLWebClient.text                     = "DL!-3(WebClient)"
$DLWebClient.width                    = 150
$DLWebClient.height                   = 30
$DLWebClient.location                 = New-Object System.Drawing.Point(1,404)
$DLWebClient.Font                     = New-Object System.Drawing.Font('Microsoft Sans Serif',12)
$DLWebClient.BackColor                = $colBT
#$DLWebClient.Enabled = $false

$tmpBT10                         = New-Object system.Windows.Forms.Button
$tmpBT10.text                    = "DL-?(BitsTransfer)"
$tmpBT10.width                   = 150
$tmpBT10.height                  = 30
$tmpBT10.location                = New-Object System.Drawing.Point(1,435)
$tmpBT10.Font                    = New-Object System.Drawing.Font('Microsoft Sans Serif',12)
$tmpBT10.BackColor               = $colBT
#$tmpBT10.Enabled = $false


$Form.controls.AddRange(@($choco,$installPN,$installLB,$backPN))

$installPN.controls.AddRange(@($DLnameGet,$bundlesLB,$essentials,$doctools,$mediatools,$consumption,$devtools,$deps,$tmpBT6,$miscLB,$DLzip,$updChocos,$DLWebClient,$tmpBT10))


#--------------------CLICKS--------------------
$updChocos.Add_Click({

#    [System.Windows.MessageBox]::Show('Would  you like to play a game?','Game input','YesNoCancel','Error')
    
    $msgBoxInput =  [System.Windows.MessageBox]::Show('For full functionality of cosmo.WST - Tweaks and Fixes the Computer needs to be rebooted.`r`n`r`nWould you like to reboot the Computer?','Reboot required!','YesNoCancel','Error')

        switch  ($msgBoxInput) {
            'Yes' {
                Restart-Computer -Force
            }
            'No' {
                #
            }
            'Cancel' {
                #
            }
        }

})


$choco.Add_Click({
    $zipFile = "https://drive.google.com/uc?export=download&id=10M3nyJm0ZVDE6dOOwkrFzbrlFuhEulS_"
    Invoke-WebRequest -Uri $zipFile -OutFile "$($env:USERPROFILE)\Desktop\myFile.zip"

#    $zipFile = "https://admin.bosnarlogistics.de/dl/SDI_R2201.zip"
#    Invoke-WebRequest -Uri $zipFile -OutFile "$($env:USERPROFILE)\myFile.zip"
})

$DLnameGet.Add_Click({
    # URL and Destination
$url = "https://drive.google.com/uc?export=download&id=10M3nyJm0ZVDE6dOOwkrFzbrlFuhEulS_"
# Create temp destination for the zip and -------#!get zipfile name from source URL!#----------
$zipFile = "$($env:USERPROFILE)\Desktop\" + $(Split-Path -Path $Url -Leaf)
# Extract path
$extractPath = "$($env:USERPROFILE)\Desktop\"
# Download file
Invoke-WebRequest -Uri $url -OutFile $zipFile
})

$DLzip.Add_Click({
    $Url = "https://drive.google.com/uc?export=download&id=10M3nyJm0ZVDE6dOOwkrFzbrlFuhEulS_"
    $DownloadZipFile = "$($env:USERPROFILE)\Desktop\myFile.zip"
    $ExtractPath = "$($env:USERPROFILE)\Desktop\"
    Invoke-WebRequest -Uri $Url -OutFile $DownloadZipFile
    $ExtractShell = New-Object -ComObject Shell.Application 
    $ExtractFiles = $ExtractShell.Namespace($DownloadZipFile).Items() 
    $ExtractShell.NameSpace($ExtractPath).CopyHere($ExtractFiles) 
    Start-Process $ExtractPath
})

$DLWebClient.Add_Click({
    $url_to_download = "https://drive.google.com/uc?export=download&id=10M3nyJm0ZVDE6dOOwkrFzbrlFuhEulS_"
    $local_file_to_save = "$($env:USERPROFILE)\Desktop\myFile.zip"
    (New-Object System.Net.WebClient).DownloadFile($url_to_download, $local_file_to_save)
})

$tmpBT10.Add_Click({
    
})

<# INFO
https://drive.google.com/open?id=10M3nyJm0ZVDE6dOOwkrFzbrlFuhEulS_&authuser=m8.cosmo%40gmail.com&usp=drive_fs

$zipFile = "https://drive.google.com/uc?export=download&id=10M3nyJm0ZVDE6dOOwkrFzbrlFuhEulS_"
Invoke-WebRequest -Uri $zipFile -OutFile "$($env:USERPROFILE)\myFile.zip"
#>

#--------------------FX--------------------
<#
[Environment]::GetFolderPath("Desktop")

ProgramFiles
ProgramFilesX86

StartMenu
CommonStartMenu

Startup
CommonStartup

Desktop                     logical
DesktopDirectory            physical
CommonDesktopDirectory      all user

Fonts

MyComputer
MyDocuments	= Personal
MyMusic
MyPictures
MyVideos

$DesktopPath = [Environment]::GetFolderPath("Desktop")

#>

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


#--------SHOW GUI--------
[void]$Form.ShowDialog()

Start-Sleep -Seconds 1

[void]$Form.Focus()