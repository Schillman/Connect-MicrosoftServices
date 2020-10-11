function Create-CredFile {
    <#
.Synopsis
Creates a Credfile
.EXAMPLE
Create-CredFile -User Seb@domain.se -CredFile 'C:\Temp\XmlFiles\Credfile.xml'
.EXAMPLE IMPORT
$Crd = Import-Clixml C:\Users\xxx\Documents\XMLCred\xxx.xml
$Crd.Password = $Crd.Password | ConvertTo-SecureString
$Creds = New-Object System.Management.Automation.PSCredential($Crd.username, $Crd.password)
#>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory, HelpMessage = "Supply your Username e.g. mail@domain.com")] [String] $User,
        [Parameter(Mandatory, HelpMessage = "FileName e.g. 'Sample.xml'")] [String]$CredFile
    )
    Begin {
        if (!$User) {Write-Output "Supply your Username e.g. 'mail@domain.com'" ; $User = Read-Host "Username"}
        if (!$CredFile) {
            $CredFile = Read-Host "FileName e.g. 'C:\Temp\XmlFiles\Credfile.xml'"
        } else {
            $Path = Split-Path $CredFile
            if (!(Test-Path $Path)) {
                New-Item -Path $Path -ItemType Directory | Out-Null
            }
        }
    }
    Process {
        $Cred = Get-Credential $User
        $Cred | Export-Clixml ($CredFile)
    }
    End {
        Remove-Variable -Name User, Credfile -ErrorAction SilentlyContinue
    }
}