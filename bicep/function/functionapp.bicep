@description('The name of you Web Site.')
param siteName string

@description('The name of storage account.')
param storageAccountName string

@description('Location for all resources.')
param location string = resourceGroup().location

@description('The name of storage account.')
param resourcegroupName string

@description('The tags of the resources.')
param tags object

@description('The name of hosting plan.')
param hostingPlanName string

resource site 'Microsoft.Web/sites@2022-03-01' = {
  name: siteName
  kind: 'functionapp,linux'
  tags: tags
  location: location
  properties: {
    siteConfig: {
      appSettings: [
        {
          name: 'FUNCTIONS_WORKER_RUNTIME'
          value: 'dotnet'
        }
        {
          name: 'FUNCTIONS_EXTENSION_VERSION'
          value: '~4'
        }
        {
          name: 'AzureWebJobsStorage'
          value: 'DefaultEndpointsProtocol=https;AccountName=${storageAccountName};AccountKey=${storageAccount.listKeys().keys[0].value}'
        }
      ]
    }
    serverFarmId: hostingPlan.id
    clientAffinityEnabled: false
  }
}

resource hostingPlan 'Microsoft.Web/serverfarms@2022-03-01' existing = {
  name: hostingPlanName
  scope: resourceGroup(resourcegroupName)
}

resource storageAccount 'Microsoft.Storage/storageAccounts@2022-05-01' existing = {
  name: storageAccountName
  scope: resourceGroup(resourcegroupName)
}
