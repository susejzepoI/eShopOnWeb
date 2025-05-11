[cmdletBinding()]
param(
    
    [parameter(Mandatory = $true)]
    [string]$RbacName,

    [parameter(Mandatory = $true)]
    [string]$RbacRole,

    [Parameter(Mandatory = $true)]
    [string]$ResourceGroupName,

    [Parameter(Mandatory = $true)]
    [string]$Location,

    [Parameter(Mandatory = $true)]
    [string]$SubscriptionId

)

az group create --name $ResourceGroupName --location $Location

az configure --defaults group=$ResourceGroupName

#JLopez-20250510: Create an application and its associated service principal, optionally configure the service principal's RBAC role assignments.
$scope = "/subscriptions/$SubscriptionId/resourceGroups/$ResourceGroupName"
az ad sp create-for-rbac --name $RbacName --role $RbacRole --scopes $scope --sdk-auth

az provider register --namespace Microsoft.Web
