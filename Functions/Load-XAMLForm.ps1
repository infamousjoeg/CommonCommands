function Load-XAMLForm {
<#
.SYNOPSIS
Converts XAML for PowerShell and loads XAML form
.DESCRIPTION
Converts Visual Studio WPF Application in Visual C# XAML into a form that is
acceptable for PowerShell to use the XAML-based form
.EXAMPLE
$formVars = Load-XAMLForm
.INPUTS
Loads xaml.xml file from working directory
.OUTPUTS
Array of form variables found
.NOTES
.LINK
#>
    [CmdletBinding()]
    Param
    ()

    BEGIN {}#begin

    PROCESS {

        $importedXML = Get-Content "${pwd}\xaml.xml"
        $parsedXML = $importedXML -replace 'mc:Ignorable="d"','' -replace "x:N",'N' -replace '^<Win.*', '<Window'

        [void][System.Reflection.Assembly]::LoadWithPartialName('PresentationFramework')
        [xml]$XAML = $parsedXML

        # Read the XAML
        $reader = (New-Object System.Xml.XmlNodeReader $XAML)
        try {
            $Form = [Windows.Markup.XamlReader]::Load($reader)
        }
        catch {
            Write-Host "Unable to load Windows.Markup.XamlReader. Double-check syntax and ensure at least .NET Framework 4.5.2 " `
                "is installed." -ForegroundColor Red
        }

        # Set variables for each object
        $XAML.SelectNodes("//*[@Name]") | %{Set-Variable -Name "WPF$($_.Name)" -Value $Form.FindName($_.Name)}

        $formVariables = @()
        $formVariables = Get-Variable WPF*

        $Form.ShowDialog() | Out-Null

        $formVariables

    }#process

    END {}#end
}