function Get-CurrentLocation {
 if ($PSScriptRoot) {
        return $PSScriptRoot
    } elseif ($psISE.CurrentFile.FullPath) {
        return Split-Path $psISE.CurrentFile.FullPath 
    } elseif ($psEditor.GetEditorContext().CurrentFile.Path) {
        return Split-Path $psEditor.GetEditorContext().CurrentFile.Path
    }
}