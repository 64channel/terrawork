$rg = 'rg-fleet-health-tfstate'
$sa = 'tfstatebkbr'
$container = 'tfstatebkbrcontainer'
$location = 'Central US'

Connect-AzAccount
$myID = Get-AzADUser -SignedIn
New-AzResourceGroup -Name $rg -Location $location
$storageAccount = New-AzStorageAccount -ResourceGroupName $rg -Name $sa -SkuName Standard_LRS -Kind StorageV2 -MinimumTlsVersion TLS1_2 -AllowBlobPublicAccess $false -location $location
Update-AzStorageBlobServiceProperty -ResourceGroupName $rg -StorageAccountName $sa -IsVersioningEnabled $true
New-AzRoleAssignment -ObjectID $myID.Id -RoleDefinitionName 'Storage Blob Data Contributor' -Scope $storageAccount.Id
Write-Output "Waiting for role to propagate. Script will wait two minutes. Go do something else for now."
Start-Sleep -Seconds 120
$storageCtx = New-AzStorageContext -StorageAccountName $sa -UseConnectedAccount
New-AzStorageContainer -Name $container -Context $storageCtx