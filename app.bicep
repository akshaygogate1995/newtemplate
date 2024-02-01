param webAppName string
param location string = 'eastus2'

resource appService 'Microsoft.Web/sites@2021-02-01' = {
  name: webAppName
  location: location
  kind: 'app'
  properties: {
    serverFarmId: null
  }
}

resource staticWebApp 'Microsoft.Web/sites@2020-12-01' = {
  name: '${webAppName}-staticwebapp'
  location: location
  properties: {
    repositoryUrl: 'https://github.com/yourusername/yourrepo'
    branch: 'main'
    buildProperties: {
      enabled: true
      appArtifactLocation: 'build'
      apiArtifactLocation: 'api'
    }
    apiType: 'functionapp'
    appSettings: {
      'WEBSITE_NODE_DEFAULT_VERSION': '14'
    }
  }
  dependsOn: [appService]
}

output endpoint string = staticWebApp.properties.defaultHostname
