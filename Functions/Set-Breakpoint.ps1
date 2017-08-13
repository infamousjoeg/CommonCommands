function Set-Breakpoint {
<#
.SYNOPSIS
Prompts to press any button to continue
.DESCRIPTION
Prompts to press any button to continue
.EXAMPLE
Set-Breakpoint
.INPUTS
Param
.OUTPUTS
None
.NOTES
.LINK
#>
    [CmdletBinding()]
    Param ()
    
    BEGIN {}#begin

    PROCESS {

        Write-Host "Press any key to continue..."
        [void]$host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")

    }#process

    END {}#end
}