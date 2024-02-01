// main.bicep

param location string = 'East US'
param appName string
param resourceGroupName string

resource staticWebApp 'Microsoft.Web/staticSites@2020-12-01' = {
  name: appName
  location: location
  properties: {
    repositoryUrl: 'https://dev.azure.com/akshaygogate100195/BlazorApp/_git/ARM'
    branch: 'main'
    buildProperties: {
      appLocation: 'Client'
      outputLocation: 'wwwroot'
    }
    appArtifactLocation: 'dist'
    customDomains: []
  }
}

output endpoint string = staticWebApp.properties.endpoint
