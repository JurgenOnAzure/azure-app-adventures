# This script shows you how to set the 'App Scale Out' limit on an Azure Function App,
# as described in this blog post: https://jurgenonazure.com/2021/11/azure-function-app-adventures-setting-the-scale-out-limit-with-powershell


# NOTE: if you haven't installed the Az PowerShell module yet,
# look here: https://docs.microsoft.com/ko-kr/powershell/azure/install-az-ps


### INPUT ###

$subscriptionId="<TODO: set your Azure subscription ID here>"
$resourceGroupName = "<TODO: set your resource group name here>"
$functionAppName = "<TODO: set your Azure Function App name here>"
$functionAppScaleLimit=10


### LOGIC ###

# Login to Azure
Connect-AzAccount -SubscriptionId $subscriptionId

Write-Output ""
Write-Output "SETTING THE SCALE LIMIT on $($functionAppName)"

# Get function app with properties
$resource = Get-AzResource `
    -ResourceType Microsoft.Web/sites `
    -ResourceGroupName $resourceGroupName `
    -ResourceName "$($functionAppName)/config/web"

# Set scale limit on properties and apply
$resource.Properties.functionAppScaleLimit = $functionAppScaleLimit
$resource | Set-AzResource -Force

Write-Output ""
Write-Output "DONE!"
