# CommonCommands

[![license](https://img.shields.io/github/license/mashape/apistatus.svg)](https://opensource.org/licenses/mit-license.php)

Common commands used regularly by me.  Compiled into a PowerShell Module.

## Latest Update

* Split functions to seperate .ps1 files
* Simplified CommonCommands.psm1
* Updated README (duh!)

### Included Functions

* Send-EmailNotification
  * Sends an HTML e-mail w/ CC, priority, and file attachment capabilities
* Get-CSVColumn
  * Gets all values of a specific column in a CSV file to an array
* Set-Log
  * Sets the path to the log file to be written to
* Write-Log
  * Writes a [DEBUG], [INFO], or [ERROR] message to the log file set
* Set-Breakpoint
  * Just pauses script until any button is pressed
* Load-XAMLForm
  * _Requires xaml.xml file in the script's working directory generated from Visual Studio - WPF Application - Visual C#_

### Future Update Functions

* Open-FileDialog
  * Displays Windows "Open File" dialog for file selection
* Save-FileDialog
  * Displays Windows "Save File" dialog for file save location selection

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

### Load-XAMLForm

The function `Load-XAMLForm` was created based on information derived from [this blog post on mcpmag.com.](https://mcpmag.com/articles/2016/04/28/building-ui-using-powershell.aspx)

The function expects a `xaml.xml` file to be located in the script's working directory that contains the XAML created from Visual Studio.

The function will load in that XAML and parse it to work within PowerShell.  It will then load up all elements from the XAML form code as variables to be worked with in the current PowerShell script.

The function will display the window and return the form variables in an array.

`$Form.ShowDialog() | Out-Null`
