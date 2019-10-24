Param (
    [parameter(Mandatory=$true)][string]$resourceGroup,
    [parameter(Mandatory=$true)][string]$sqlPwd,
    [parameter(Mandatory=$false)][string]$outputFile=$null,
    [parameter(Mandatory=$false)][string]$gvaluesTemplate="$PSScriptRoot/gvalues.template",
    [parameter(Mandatory=$false)][bool]$forcePwd=$false,
    [parameter(Mandatory=$false)][bool]$infraOutsideAKS=$true
)

function EnsureAndReturnFistItem($arr, $restype) {
    if (-not $arr -or $arr.Length -ne 1) {
        Write-Host "Fatal: No $restype found (or found more than one)" -ForegroundColor Red
        exit 1
    }
    return $arr[0]
}

# Check the rg
$rg=$(az group show -n $resourceGroup -o json | ConvertFrom-Json)

if (-not $rg) {
    Write-Host "Fatal: Resource group not found" -ForegroundColor Red
    exit 1
}

### Getting Resources
$tokens=@{}

if ($infraOutsideAKS) {
    $sqlsrv=$(az sql server list -g $resourceGroup --query "[].{administratorLogin:administratorLogin, name:name, fullyQualifiedDomainName: fullyQualifiedDomainName}" -o json | ConvertFrom-Json)
    $sqlsrv=EnsureAndReturnFistItem $sqlsrv "SQL Server"
    Write-Host "Sql Server: $($sqlsrv.name)" -ForegroundColor Yellow

    ### Getting postgreSQL info
    $pg=$(az postgres server list -g $resourceGroup --query "[].{administratorLogin:administratorLogin, name:name, fullyQualifiedDomainName: fullyQualifiedDomainName}" -o json | ConvertFrom-Json)
    $pg=EnsureAndReturnFistItem $pg "PostgreSQL"
    Write-Host "PostgreSQL Server: $($pg.name)" -ForegroundColor Yellow

    ## Getting storage info
    #$storage=$(az storage account list -g $resourceGroup --query "[].{name: name, blob: primaryEndpoints.blob}" -o json | ConvertFrom-Json)
    #$storage=EnsureAndReturnFistItem $storage "Storage Account"
    $storage=$(az storage account list -g $resourceGroup --query [0].primaryEndpoints.blob -o tsv)
    # Write-Host "Storage Account: $($storage.name)" -ForegroundColor Yellow

    ## Getting CosmosDb info
    $docdb=$(az cosmosdb list -g $resourceGroup --query "[?kind=='GlobalDocumentDB'].{name: name, kind:kind, documentEndpoint:documentEndpoint}" -o json | ConvertFrom-Json)
    $docdb=EnsureAndReturnFistItem $docdb "CosmosDB (Document Db)"
    $docdbKey=$(az cosmosdb list-keys -g $resourceGroup -n $docdb.name -o json --query primaryMasterKey | ConvertFrom-Json)
    Write-Host "Document Db Account: $($docdb.name)" -ForegroundColor Yellow

    $mongodb=$(az cosmosdb list -g $resourceGroup --query "[?kind=='MongoDB'].{name: name, kind:kind}" -o json | ConvertFrom-Json)
    $mongodb=EnsureAndReturnFistItem $mongodb "CosmosDB (MongoDb mode)"
    $mongodbKey=$(az cosmosdb list-keys -g $resourceGroup -n $mongodb.name -o json --query primaryMasterKey | ConvertFrom-Json)
    Write-Host "Mongo Db Account: $($mongodb.name)" -ForegroundColor Yellow

    if ($forcePwd) {
        Write-Host "Reseting password to $sqlPwd for SQL server $($sqlsrv.name)" -ForegroundColor Yellow
        az sql server update -n $sqlsrv.name -g $resourceGroup -p $sqlPwd

        Write-Host "Reseting password to $sqlPwd for PostgreSQL server $($pg.name)" -ForegroundColor Yellow
        az postgres server update -n $pg.name -g $resourceGroup -p $sqlPwd
    }

    ## Showing Values that will be used

    Write-Host "===========================================================" -ForegroundColor Yellow
    Write-Host "gvalues file will be generated with values:"

    $tokens.dbhost=$sqlsrv.fullyQualifiedDomainName
    $tokens.dbuser=$sqlsrv.administratorLogin
    $tokens.dbpwd=$sqlPwd

    $tokens.pghost=$pg.fullyQualifiedDomainName
    $tokens.pguser="$($pg.administratorLogin)@$($pg.name)"
    $tokens.pgpwd=$sqlPwd

    $tokens.carthost=$docdb.documentEndpoint
    $tokens.cartauth=$docdbKey

    $tokens.couponsuser=$mongodb.name
    $tokens.couponshost="$($mongodb.name).documents.azure.com"
    $tokens.couponspwd=$mongodbKey

    $tokens.storage=$storage
}

## Getting App Insights instrumentation key
$appinsights=$(az monitor app-insights component show --app tt-app-insights -g $resourceGroup -o json | ConvertFrom-Json)
Write-Host "App Insights Instrumentation Key: $($appinsights)" -ForegroundColor Yellow

$tokens.appinsightsik=$appinsights.instrumentationKey

# Standard fixed tokens
$tokens.ingressclass="addon-http-application-routing"
$tokens.secissuer="TTFakeLogin"
$tokens.seckey="nEpLzQJGNSCNL5H6DIQCtTdNxf5VgAGcBbtXLms1YDD01KJBAs0WVawaEjn97uwB"

Write-Host ($tokens | ConvertTo-Json) -ForegroundColor Yellow

Write-Host "===========================================================" -ForegroundColor Yellow

& $PSScriptRoot/token-replace.ps1 -inputFile $gvaluesTemplate -outputFile $outputFile -tokens $tokens