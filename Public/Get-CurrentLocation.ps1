function Get-CurrentLocation {
    <#
    .DESCRIPTION
       A function that no matter what IDE you are using it will return the current Path 
    .EXAMPLE
        Get-CurrentLocation
        C:\Users\<UserName>
    #>
 if ($PSScriptRoot) {
        return $PSScriptRoot
    } elseif ($psISE.CurrentFile.FullPath) {
        return Split-Path $psISE.CurrentFile.FullPath 
    } elseif ($psEditor.GetEditorContext().CurrentFile.Path) {
        return Split-Path $psEditor.GetEditorContext().CurrentFile.Path
    }
}