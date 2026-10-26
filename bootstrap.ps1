# This script is only meant to run once
# It also assumes that the app-fleet-health-github-oidc app is already created so make sure that that's made too
# Will fix at some point idk

$rg = 'rg-fleet-health-tfstate'
$sa = 'tfstatebkbr'
$container = 'tfstatebkbrcontainer'
$location = 'Central US'

Connect-AzAccount
Write-Output "Just so you know, you're currently working in $((Get-AzContext).Subscription.Name)"
$me = Get-AzADUser -SignedIn
New-AzResourceGroup -Name $rg -Location $location
$storageAccount = New-AzStorageAccount -ResourceGroupName $rg -Name $sa -SkuName Standard_LRS -Kind StorageV2 -MinimumTlsVersion TLS1_2 -AllowBlobPublicAccess $false -location $location
Update-AzStorageBlobServiceProperty -ResourceGroupName $rg -StorageAccountName $sa -IsVersioningEnabled $true
New-AzRoleAssignment -ObjectID $me.Id -RoleDefinitionName 'Storage Blob Data Contributor' -Scope $storageAccount.Id
Write-Output "Waiting for role to propagate. Script will wait two minutes. Go do something else for now."
Start-Sleep -Seconds 120
$storageCtx = New-AzStorageContext -StorageAccountName $sa -UseConnectedAccount
New-AzStorageContainer -Name $container -Context $storageCtx
$sp = Get-AzADServicePrincipal -DisplayName 'app-fleet-health-github-oidc'
$subScope = "/subscriptions/$((Get-AzContext).Subscription.Id)"
New-AzRoleAssignment -ObjectID $sp.Id -RoleDefinitionName 'Contributor' -Scope $subScope
New-AzRoleAssignment -ObjectID $sp.Id -RoleDefinitionName 'Storage Blob Data Contributor' -Scope $storageAccount.Id