Function Confirm-Prompt {

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