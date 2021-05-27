use namespace System.Management.Automation
use namespace System.Net

Import-Module -Name 'MSOnline'
Import-Module -Name 'AzureAD'
Import-Module -Name 'Microsoft.Online.SharePoint.PowerShell'
Import-Module -Name 'PnP.PowerShell'

$UserName = 'uuuu@xxxx.onmicrosoft.com'
$Password = ''
$AdminUrl = 'https://xxxx-admin.sharepoint.com'

$Credential = [PSCredential]::new($UserName, (ConvertTo-SecureString $Password -AsPlainText -Force ))

Connect-MsolService -Credential $Credential
Connect-SPOService -Credential $Credential -Url $AdminUrl
Connect-PnPOnline –Url $AdminUrl -UseWebLogin

Connect-PnPOnline -Url $AdminUrl -DeviceLogin -LaunchBrowser
# Check Terminal for Code!!!



Get-SPOSite

New-SPOSite -Url https://XXXX.sharepoint.com/sites/hr -Title "HR Home" -Owner steve@XXXX.onmicrosoft.com -StorageQuota 1024 -Template STS#0

Get-SPOSite

	
New-PnPSite -Type TeamSite -Title 'Team CK' -Alias TeamCK
New-PnPSite -Type TeamSite -Title 'Project Site' -Alias ProjectSite
New-PnPSite -Type TeamSite -Title 'Team Site' -Alias TeamSite

Set-SPOUser -site https://XXXX.sharepoint.com/sites/hr -LoginName shannen@XXXX.onmicrosoft.com -IsSiteCollectionAdmin $True
Get-SPOUser -Site https://XXXX.sharepoint.com/sites/hr | Where-Object { $_.IsSiteAdmin }

$SPOSites = Get-SPOSite | Select-Object *
	
ForEach ($SPOSite in $SPOSites) {
    Write-Host "Admins for " $SPOSite.Url -foregroundcolor Yellow
    Get-SPOUser -Site $SPOSite.Url | Where-Object {$_.IsSiteAdmin}
    Write-Host
}

	
Set-SPOSite -Identity https://XXXX.sharepoint.com/sites/intranet -StorageQuota 15000 -StorageQuotaWarningLevel 13000


$SPOSites = Get-SPOSite | Select-Object *
	
ForEach ($SPOSite in $SPOSites) {
    Write-Host "Changing Quota for " $SPOSite.Url -ForegroundColor Yellow
    Set-SPOSite -Identity $SPOSite.Url -StorageQuota 12500 -StorageQuotaWarningLevel 11000
    Write-Host
}

# Remove Office 365 Group First
# Remove-MsolGroup << AAD Groups
# Remove-unifiedGroup << Exchange Online
# Remove-SPOSiteGroup -Site https://XXXX.sharepoint.com/sites/ProjectSite -Identity NameOfTheGroup

Remove-SPOSite -Identity https://XXXX.sharepoint.com/sites/ProjectSite
Remove-SPODeletedSite -Identity https://XXXX.sharepoint.com/sites/ProjectSite
