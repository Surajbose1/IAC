@description('The name of you Web Site.')
param siteName string

@description('Resource Group name')
param resourceGroupName string

@description('Resource Group location')
param resourceGroupLocation string

@description('Storage account name')
param storageAccountName string

@description('The tags of the resources.')
param tags object

@description('The name of hosting plan.')
param hostingPlanName string

targetScope = 'subscription'

resource resourceGroup 'Microsoft.Resources/resourceGroups@2022-09-01' = {
name: resourceGroupName
location: resourceGroupLocation
tags: tags
}

module azfunction 'function/functionapp.bicep' = {
  name: 'az-fn-app'
  scope: resourceGroup
  params: {
    siteName: siteName
    storageAccountName: storageAccountName
    location: resourceGroupLocation
    resourcegroupName: resourceGroupName
    tags: tags
    hostingPlanName: hostingPlanName   
  }
}
