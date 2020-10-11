function Find-YourModule {
    <#
    .Synopsis
        A function to check if a a specific module is availeble on your system, if not then ask if you want to install it in Scope CurrentUser
    .EXAMPLE
        Find-YourModule MicrosoftTeams
    #>
    
    [CmdletBinding()]
    Param  (
        # Module to look for and install if missing.
        [Parameter(Mandatory)]
        [string]
        $ModuleName
    )
    Process {
    
        if (!(Get-Module $ModuleName -ListAvailable)) {

                $Install = Confirm-Prompt -Message "Missing Module: `'$ModuleName`'`nWould you like to install it?" -barTitle 'Confirm installation' -Icon Question -buttonStyle YesNo
    
                Switch ($Install) {
    
                    Yes {
                        try {
                            $error.Clear()
                            Install-Module -Name $ModuleName -Scope CurrentUser
                        }
                        catch {
                            Write-Host $error[0].Exception.Message -ForegroundColor Red
                            Write-Output "Couldn't install '$ModuleName' which is a required Module"
                            Read-Host 'Press enter to close exit'
                            Exit
                        }
                    }
                    No {
                        Write-Output "$ModuleName is a required Module"
                        Read-Host 'Press enter to close exit'
                        Exit
                    }
    
                }
        } else { Write-Verbose "$ModuleName successfully installed" }
    } End {
        if ($Install -eq 'Yes' -and !$error) {
            Write-Verbose "$ModuleName successfully installed"
        } elseif ($install-eq 'Yes' -and $error) {
            Write-Warning "Something went wrong... Installation for'$ModuleName' might have failed.`nError: $($Error[0].Exception.Message)"
        } elseif ($install -eq 'No') {
            Write-Host "The module '$ModuleName' is requiered" -ForegroundColor Red
            Read-Host 'Press enter to close exit'
            Exit
        }

    }
}