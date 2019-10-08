param (
    [string]$azureResourceGroup,
    [string]$storageAccountName
)

Install-Module -Name Az -AllowClobber -Scope AllUsers -Force

$storageAccount = Get-AzStorageAccount -ResourceGroupName $azureResourceGroup -Name $storageAccountName
New-AzStorageTable –Name oncall –Context $storageAccount.Context