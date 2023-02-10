@description('Resource Group name')
param resourceGroupName string

@description('Resource Group location')
param resourceGroupLocation string

@description('Storage account name')
param storageAccountName string

@description('The tags of the resources.')
param tags object

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
    location: resourceGroupLocation
    // siteName: ''
    tags: tags
    storageAccountName: storageAccountName
  }
}
