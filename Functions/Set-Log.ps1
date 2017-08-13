function Set-Log {
<#
.SYNOPSIS
Set path to log file
.DESCRIPTION
Sets the path to the log file Write-Log will write to
.PARAMETER logPath
Filesystem path to log file
.EXAMPLE
$password_name = Set-Log -logPath "C:\Users\jgarcia\Documents\test.log"
.INPUTS
Param
.OUTPUTS
None
.NOTES
TODO: Add pipeline support
.LINK
#>
    [CmdletBinding()]
    Param
    (
        [Parameter(Mandatory=$true)]
        [string]
        $logPath
    )

    BEGIN {}#begin

    PROCESS {

        $now = Get-Date -Format "MM-dd-yyyy hh:mm:ss"
        $logHeader = "[ ${now} ]                 "

        if (!(Test-Path $logPath)) {
            $logEntry = $logHeader + "[INFO] Created log file at ${logPath}"
            Set-Content -Path $logPath -Value $logEntry
        }
        else {
            $logEntry = $logHeader + "[INFO] Initialized log file at ${logPath}"
            Add-Content -Path $logPath -Value $logEntry
        }

        $Global:logPath = $logPath

    }#process

    END {}#end
}