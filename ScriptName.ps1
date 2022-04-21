$Name = "testapp"


powershell -noexit -ExecutionPolicy Bypass -File .\$Name.ps1

Exit


<#
ScriptStarter - Shortcut DestinationPath:
C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -ExecutionPolicy Bypass -File .\ScriptName.ps1

~ Or just:
powershell -ExecutionPolicy Bypass -File .\ScriptName.ps1
#>