function Get-CSVColumn {
<#
.SYNOPSIS
Get all values from a CSV column
.DESCRIPTION
Loop through every row of a CSV file and grab the value of a specific column into an array
.PARAMETER csvFilePath
Filesystem path to CSV file
.PARAMETER to
Column name to iterate through
.EXAMPLE
$password_name = Get-CSVColumn -csvFilePath "C:\Users\jgarcia\Documents\passwords.csv" -columnName "password_name"

.INPUTS
Param
.OUTPUTS
An array of all column values returned from CSV
.NOTES
.LINK
#>
    [CmdletBinding()]
    Param
    (
        [parameter(Mandatory=$true)]
        [string]
        $csvFilePath,
        [parameter(Mandatory=$true)]
        [string]
        $columnName
    )

    BEGIN {}#begin

    PROCESS {

        $csvImport = Import-CSV "${csvFilePath}"

        $columnValues = @()

        foreach ($value in $csvImport)
        {
            $columnValues += $value.'$columnName'
        }

        $columnValues

    }#process

    END {}#end
}