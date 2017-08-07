###########################################################################################################################
#
#   Script Name:    CommonCommands.psm1
#   Author:         Joe Garcia, Technical Advisor, North American Customer Success, CyberArk Software
#   Date Created:   4/6/2016
#   Date Modified:  
#   Description:    PowerShell Module compiled to store all commonly used general functions.
#
###########################################################################################################################

##############################
#
# FUNCTIONS
#
##############################

##############################
# Convert-BodyAsHTML
##############################

Function Convert-BodyAsHTML
{
    # Declare function variable parameters
    Param(
        [parameter(Mandatory=$true)]
        [string]
        $plainTextBody
    )

    # HTML Header
    $bodyAsHTML = "<html><head></head><body>"
    # Plain Text Body
    $bodyAsHTML += $plainTextBody
    # HTML Footer
    $bodyAsHTML += "</body></html>"

    # Return value
    $bodyAsHTML
}

##############################
# Send-EmailNotification
##############################

Function Send-EmailNotification
{
    Param(
        [parameter(Mandatory=$true)]
        [string]
        $smtpServer,
        [parameter(Mandatory=$true)]
        [string]
        $to,
        [parameter(Mandatory=$true)]
        [string]
        $from,
        [parameter(Mandatory=$false)]
        [string]
        $cc = $null,
        [parameter(Mandatory=$true)]
        [string]
        $subject,
        [parameter(Mandatory=$true)]
        [string]
        $body,
        [parameter(Mandatory=$false)]
        [string]
        $attachmentPath
        [parameter(Mandatory=$true)]
        [ValidateSet("Low","Normal","High")]
        [string]
        $priority
    )

    # Set errorFlag to $true - No errors (yet)
    $errorFlag = $true

    # Check body variable for HTML tags
    if ($body -notmatch "<HTML>" -and $body -notmatch "<html>")
    {
        # If no HTML tags found, convert body to HTML
        try 
        {
            Convert-BodyAsHTML -bodyAsHTML $body
        }
        catch 
        {
            $errorFlag = $false
        }
    }

    # Send email notification with parameters given, if errorFlag is still $true
    if ($errorFlag) {
        try
        {
            Send-MailMessage -To $to -From $from -Cc $cc -Subject $subject -Body $body -BodyAsHTML -SmtpServer $smtpServer -Attachments $attachmentPath -Priority $priority
        }
        catch
        {
            $errorFlag = $false
        }
    }

    # Returns $true for no errors and $false for errors
    $errorFlag
}

##############################
# Get-CSVColumn
##############################

Function Get-CSVColumn
{
    Params
    (
        [parameter(Mandatory=$true)]
        [string]
        $csvFilePath,
        [parameter(Mandatory=$true)]
        [string]
        $columnName
    )

    $csvImport = Import-CSV "$csvFilePath"

    $columnValues = @()

    foreach ($value in $csvImport)
    {
        $columnValues += $value.'$columnName'
    }

    $columnValues

}

##############################
#
# EXPORT
#
##############################

Export-ModuleMember -Function Convert-BodyAsHTML
Export-ModuleMember -Function Send-EmailNotification
Export-ModuleMember -Function Get-CSVColumn