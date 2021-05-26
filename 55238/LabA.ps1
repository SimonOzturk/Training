use namespace System.Management.Automation
use namespace System.Net

[ServicePointManager]::SecurityProtocol = [SecurityProtocolType]::Tls12
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned 
Set-PSRepository -Name 'PSGallery' -InstallationPolicy Trusted

Install-Module -Name 'MSOnline' -Confirm:$false -Force
Install-Module -Name 'AzureAD' -Confirm:$false -Force
Install-Module -Name 'Microsoft.Online.SharePoint.PowerShell' -Confirm:$false -Force
Install-Module -Name 'PnP.PowerShell' -Confirm:$false -Force

Import-Module -Name 'MSOnline'
Import-Module -Name 'AzureAD'
Import-Module -Name 'Microsoft.Online.SharePoint.PowerShell'
Import-Module -Name 'PnP.PowerShell'

$UserName = 'uuuu@xxxx.onmicrosoft.com'
$Password = ''
$AdminUrl = 'xxxx-admin.sharepoint.com'

$Credential = [PSCredential]::new($UserName, (ConvertTo-SecureString $Password -AsPlainText -Force ))

Connect-MsolService -Credential $Credential
Connect-SPOService -Credential $Credential -Url $AdminUrl

Get-MsolUser

New-MsolUser –UserPrincipalName Pete@xxxx.onmicrosoft.com –DisplayName 'Pete Coventry' –FirstName 'Pete' –LastName 'Coventry' –Password 'Pa$$w0rd' -ForceChangePassword $false –UsageLocation 'GB'
New-MsolUser –UserPrincipalName Ashley@xxxx.onmicrosoft.com –DisplayName 'Ashley Curtis' –FirstName 'Ashley' –LastName 'Curtis' –Password 'Pa$$w0rd' -ForceChangePassword $false –UsageLocation 'GB'
New-MsolUser –UserPrincipalName Mark@xxxx.onmicrosoft.com –DisplayName 'Mark Summers' –FirstName 'Mark' –LastName 'Summers' –Password 'Pa$$w0rd' -ForceChangePassword $false –UsageLocation 'GB'
New-MsolUser –UserPrincipalName Shannen@xxxx.onmicrosoft.com –DisplayName 'Shannen Smith' –FirstName 'Shannen' –LastName 'Smith' –Password 'Pa$$w0rd' -ForceChangePassword $false –UsageLocation 'GB'
New-MsolUser –UserPrincipalName Tom@xxxx.onmicrosoft.com –DisplayName 'Tom Gooch' –FirstName 'Tom' –LastName 'Gooch' –Password 'Pa$$w0rd' -ForceChangePassword $false –UsageLocation 'GB'

Set-MsolUserLicense -AddLicenses 'XXXX:ENTERPRISEPREMIUM' –UserPrincipalName Pete@xxxx.onmicrosoft.com
Set-MsolUserLicense -AddLicenses 'XXXX:ENTERPRISEPREMIUM' –UserPrincipalName Ashley@xxxx.onmicrosoft.com
Set-MsolUserLicense -AddLicenses 'XXXX:ENTERPRISEPREMIUM' –UserPrincipalName Mark@xxxx.onmicrosoft.com
Set-MsolUserLicense -AddLicenses 'XXXX:ENTERPRISEPREMIUM' –UserPrincipalName Shannen@xxxx.onmicrosoft.com 
Set-MsolUserLicense -AddLicenses 'XXXX:ENTERPRISEPREMIUM' –UserPrincipalName Tom@xxxx.onmicrosoft.com


$Users = Get-Content .\Users.json  | ConvertFrom-Json
ForEach ($User in $Users) {
    New-MsolUser –UserPrincipalName $User.UserPrincipalName –DisplayName $User.DisplayName –FirstName $User.FirstName –LastName $User.LastName –Password $User.Password -ForceChangePassword $User.ForceChangePassword –UsageLocation $User.UsageLocation
}
Get-MsolUser -UnlicensedUsersOnly | Set-MsolUserLicense -AddLicenses 'XXXX:ENTERPRISEPREMIUM'