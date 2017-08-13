function Write-Log {
<#
.SYNOPSIS
Writes a message to the log
.DESCRIPTION
Writes a message with date/time, type, message
.PARAMETER logPath
Filesystem path to log file
.PARAMETER logLevel
Level tag for the log message
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
        $logEntry,
        [parameter(Mandatory=$true)]
        [ValidateSet("DEBUG","INFO","ERROR")]
        [string]
        $logLevel="INFO"
    )

    BEGIN {}#begin

    PROCESS {

        try {
            $now = Get-Date -Format "MM-dd-yyyy hh:mm:ss"
            $logHeader = "[ ${now} ]                 [ ${logLevel} ] "

            $logEntry = $logHeader + $logEntry
            Add-Content -Path $Global:logPath -Value $logEntry
            return $true
        }
        catch {
            return $false
        }

    }#process

    END {}#end
}