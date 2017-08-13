# CommonCommands

[![license](https://img.shields.io/github/license/mashape/apistatus.svg)](https://opensource.org/licenses/mit-license.php)

Common commands used regularly by me.  Compiled into a PowerShell Module.

## Latest Update

* Split functions to seperate .ps1 files
* Simplified CommonCommands.psm1
* Updated README (duh!)

## Included Functions

* Send-EmailNotification
* Get-CSVColumn
* Set-Log
* Write-Log
* Set-Breakpoint
* Load-XAMLForm

### Future Update Functions

* Open-FileDialog
* Save-FileDialog

## Pre-Requisites

* PowerShell v3 or higher

## Usage

Clone this repository into one of the directories listed as your PSMODULEPATH environment variable.

Run a PowerShell console and do the following:

```
$modulePath = @(($env:PSMODULEPATH.Split(";")))
Write-Host $modulePath[0]
```

The value of `$modulePath` is one of your recognized PowerShell Module directories.

```
cd $modulePath[0]
git clone https://github.com/infamousjoeg/CommonCommands.git
```

That will download all the files into a "CommonCommands" directory in the proper location.

```
Import-Module CommonCommands
Get-Command -Module CommonCommands
```