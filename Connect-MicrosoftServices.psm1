function Get-CurrentLocation {
    if ($PSScriptRoot) {
           return $PSScriptRoot
       } elseif ($psISE.CurrentFile.FullPath) {
           return Split-Path $psISE.CurrentFile.FullPath 
       } elseif ($psEditor.GetEditorContext().CurrentFile.Path) {
           return Split-Path $psEditor.GetEditorContext().CurrentFile.Path
       }
}

$scriptRoot = (Get-CurrentLocation) + '\public'

Get-ChildItem $scriptRoot *.ps1 | ForEach-Object {
    Import-Module $_.FullName -Force
}