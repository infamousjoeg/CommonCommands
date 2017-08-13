function Load-XAMLForm {
<#
.SYNOPSIS
Converts XAML for PowerShell and loads XAML form
.DESCRIPTION
Converts Visual Studio WPF Application in Visual C# XAML into a form that is
acceptable for PowerShell to use the XAML-based form
.PARAMETER XAML
The XAML from Visual Studio
.EXAMPLE
## Replace XAML between $inputXAML = @" "@
$inputXAML = @"
    <Window x:Class="Azure.Window1"
            xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
            xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
            xmlns:d="http://schemas.microsoft.com/expression/blend/2008"
            xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006"
            xmlns:local="clr-namespace:Azure"
            mc:Ignorable="d"
    
            Title="iVision Azure Accelerator" Height="524.256" Width="332.076">
        <Grid Margin="0,0,174,0">
        </Grid>
    </Window>
"@

$formVars = Load-XAMLForm $inputXAML
.INPUTS
Param
.OUTPUTS
Array of form variables found
.NOTES
TODO: Add pipeline support
.LINK
#>
    [CmdletBinding()]
    Param
    (
        [Parameter(Mandatory=$true)]
        [string]
        $XAML
    )

    BEGIN {}#begin

    PROCESS {

        $parsedXML = $XAML -replace 'mc:Ignorable="d"','' -replace "x:N",'N' -replace '^<Win.*', '<Window'

        [void][System.Reflection.Assembly]::LoadWithPartialName('PresentationFramework')
        Remove-Variable $XAML
        [xml]$XAML = $parsedXML

        # Read the XAML
        $reader = (New-Object System.Xml.XmlNodeReader $XAML)
        try {
            $Form = [Windows.Markup.XmlReader]::Load($reader)
        }
        catch {
            Write-Host "Unable to load Windows.Markup.XamlReader. Double-check syntax and ensure at least .NET Framework 4.5.2 " `
                "is installed." -ForegroundColor Red
        }

        # Load XAML Objects in PowerShell
        $XAML.SelectNodes("//*[@Name]") | %{Set-Variable -Name "WPF$($_.Name)" -Value $Form.FindName($_.Name)}

        $formVariables = @()
        $formVariables = Get-Variable WPF*

        $Form.ShowDialog() | Out-Null

        $formVariables

    }#process

    END {}#end
}