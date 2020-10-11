function Connect-MicrosoftServices {
    <#
.Synopsis
   Short description
.DESCRIPTION
   Long description
.EXAMPLE
   Example of how to use this cmdlet
.EXAMPLE
   Another example of how to use this cmdlet
#>
    [CmdletBinding()]
    Param
    (
        # The Service you'de like install if missing and then connect to.
        [Parameter(Mandatory)]
        [ValidateSet('MSOnline', 'ExchangeOnlineManagement', 'MicrosoftTeams', 'Az', 'ComplienceCenter')]   
        [String[]]
        $Services
    )

    Begin {
        
        # Controll that the module is installed if missing ask to install it.
        Foreach ($Module in $Services) {
            Find-YourModule $Module
        }

        $ConnectCmdlets = [Ordered]@{
            MicrosoftTeams           = "Connect-MicrosoftTeams"
            ExchangeOnlineManagement = 'Connect-ExchangeOnline' # If ($Credential)  {"Param($Credential); `$Session = New-PSSession -ConfigurationName ExchangeOnline -ConnectionUri https://outlook.office365.com/powershell-liveid/ -Credential `$Credential -Authentication Basic -AllowRedirection ; Import-PSSession `$Session"} else {'Connect-ExchangeOnline'}
            MSOnline                 = "Connect-MsolService"
            Az                       = "Connect-AzAccount"
            ComplienceCenter         = "Connect-IPPSSession"
        }

    } Process {

        foreach ($Service in $Services) {
            try {
                Invoke-Command -ScriptBlock ([Scriptblock]::Create($ConnectCmdlets[$Service]))
            }
            catch {
                Write-Host "Error: $($_.Exception.Message)`nTrace: $($_.ScriptStackTrace)" -ForegroundColor Red
            }
            
        }


    } End {

    }
}