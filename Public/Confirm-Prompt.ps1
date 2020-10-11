Function Confirm-Prompt {
<#
.SYNOPSIS
    A Simple function to prompt give a GUI Prompt for windows. it uses the assemblyname 'PresentationFramework'
.EXAMPLE
    Confirm-Prompt -Message "Missing Module: `'$ModuleName`'`nWould you like to install it?" -barTitle 'Confirm installation' -Icon Question -buttonStyle YesNo
    This will popup a windows where the User have to answer the prompt with a Yes or No, Icon will in this case display a Questionmark besid the actuall message in the prompt.
#>
    [CmdletBinding()]
    Param  (
        [Parameter(Mandatory)]
        [string]
        $Message, 

        [Parameter()]
        [string]
        $barTitle = ($Message[0..10] -join '') + ('...'),

        [Parameter()]
        [string]
        [ValidateSet('Asterisk', 'Error', 'Exclamation', 'Hand', 'Information', 'None', 'Question', 'Stop', 'Warning')]
        $Icon = 'None',

        [Parameter()]
        [string]
        [ValidateSet('YesNoCancel', 'YesNo', 'Ok/Cancel', 'OK')]
        $buttonStyle = 'OK'
    )
    Add-Type -AssemblyName PresentationFramework
    $Button = [System.Windows.MessageBoxButton]::$buttonStyle
    $Pic = [System.Windows.MessageBoxImage]::$Icon

    Write-Verbose "Message: $Message`nbarTitle: $barTitle`nIcon: $Icon`nbuttonStyle: $buttonStyle"

    $Prompt = [System.Windows.MessageBox]::Show($Message, $barTitle, $Button, $Pic) 

    return $Prompt

}