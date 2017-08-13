function Send-EmailNotification {
    <#
.SYNOPSIS
Send e-mail notification.
.DESCRIPTION
Sends a plaintext or html e-mail to an address or group of addresses.
.PARAMETER smtpServer
Server address to use for SMTP
.PARAMETER to
Email address(es) to send email to
.PARAMETER from
Email address to send email from
.PARAMETER cc
Email address(es) to cc
Defaults to none
.PARAMETER subject
Subject the email should contain
.PARAMETER body
Body of the email message
.PARAMETER attachmentPath
Filepath to an attachment to add to the email
.PARAMETER priority
Sets the priority of the message - Low, Normal, High
Default to Normal
.EXAMPLE
$successFlag = Send-EmailNotification -smtpServer "smtp.google.com" -to "john@cyberark.com" -from "mike@cyberark.com" `
                -subject "Call me ASAP" -body "CALL ME QUICK!" -attachmentPath "C:\Users\mike\Documents\Q2_Earnings.xls" `
                -priority "High"
.INPUTS
Param
.OUTPUTS
$true = no error // $false = error
.NOTES
.LINK
#>
    [CmdletBinding()]
    Param
    (
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
        $attachmentPath,
        [parameter(Mandatory=$true)]
        [ValidateSet("Low","Normal","High")]
        [string]
        $priority="Normal"
    )

    BEGIN {

        # Set errorFlag to $true - No errors (yet)
        $errorFlag = $true

    }#begin

    PROCESS {

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

    }#process

    END {}#end
}