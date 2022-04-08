#--------------------FUNCTIONS--------------------

#--------LOGGER FX--------
function Write-Log{
    $LogMsg = $args[0]
    Write-Host $LogMsg
    $ResultText.AppendText("`r`n"+$LogMsg)
}

#--------INSTALL FX--------
<#function Install-Software{
    $AppName = $args[0]
    Write-Host "Installing" $AppName
    $ResultText.AppendText("`r`n" +"`r`n" + "Installing " + $AppName + "... Please Wait")
    #choco...
    Write-Host "Installed" $AppName 
    $ResultText.AppendText("`r`n" + "Finished Installing " + $AppName + "`r`n" + "`r`n" + "Ready for Next Task")
}#>

function Install-Software{
    $AppName = $args[0]
    Write-Log ("`r`n" + "Installing " + $AppName)
    Write-Log ("...Please Wait")
    #choco...
    Write-Log ("Finished Installing " + $AppName)
    Write-Log (" >>> Ready for Next Task")
}

#--------RESTORE POINT FX--------
function Add-RestorePoint{
    Write-Log "Creating Restorepoint..."

    
}

#--------TWEAKS FXs--------
function Set-Essentials{
    $setTo = $args[0]

    if ($setTo -eq "on"){
        Write-Host "on"
        
    }
    else{
        Write-Host "off"

    }
}

function Set-Darkmode{
    $setTo = $args[0]

    if ($setTo -eq "on"){
        Write-Host "on"
        
    }
    else{
        Write-Host "off"

    }
}

function Set-FancyVFX{
    $setTo = $args[0]

    if ($setTo -eq "on"){
        Write-Host "on"
        
    }
    else{
        Write-Host "off"

    }
}

function Set-BGApps{
    $setTo = $args[0]

    if ($setTo -eq "on"){
        Write-Host "on"
        
    }
    else{
        Write-Host "off"

    }
}

function Set-OneDrive{
    $setTo = $args[0]

    if ($setTo -eq "on"){
        Write-Host "on"
        
    }
    else{
        Write-Host "off"

    }
}

function Set-LocTracking{
    $setTo = $args[0]

    if ($setTo -eq "on"){
        Write-Host "on"
        
    }
    else{
        Write-Host "off"

    }
}

function Set-UTCTime{
    $setTo = $args[0]

    if ($setTo -eq "on"){
        Write-Host "on"
        
    }
    else{
        Write-Host "off"

    }
}

function Set-Telemetry{
    $setTo = $args[0]

    if ($setTo -eq "on"){
        Write-Host "on"
        
    }
    else{
        Write-Host "off"

    }
}

