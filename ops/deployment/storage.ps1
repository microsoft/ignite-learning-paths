param (
    [string]$azureResourceGroup,
    [string]$storageAccountName
)

$storageAccount = Get-AzStorageAccount -ResourceGroupName $azureResourceGroup -Name $storageAccountName
New-AzStorageTable –Name oncall –Context $storageAccount.Context