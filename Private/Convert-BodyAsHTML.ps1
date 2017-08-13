function Convert-BodyAsHTML {
    <#
.SYNOPSIS
Wraps HTML around plaintext
.DESCRIPTION
Takes plaintext and generates an HTML body to be used in e-mails
.PARAMETER plaintextBody
The plaintext that will be wrapped in HTML tags
.EXAMPLE
$htmlText = Convert-BodyAsHTML -plaintextBody "This is a test message."
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
        $plainTextBody
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