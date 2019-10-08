param (
    [string]$azureResourceGroup,
    [string]$storageAccountName
)

Install-Module -Name Az -AllowClobber -Scope AllUsers

$storageAccount = Get-AzStorageAccount -ResourceGroupName $azureResourceGroup -Name $storageAccountName
New-AzStorageTable –Name oncall –Context $storageAccount.Context