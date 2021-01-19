param webAppName string {
  minLength: 2
  default: uniqueString(resourceGroup().id)
}

param location string {
  default: resourceGroup().location
}

resource containerRegistry 'Microsoft.ContainerRegistry/registries@2020-11-01-preview' = {
  name: '${webAppName}acr'
  location: location
  sku: {
    name: 'Standard'
  }
  properties: {
    adminUserEnabled: true
  }
}

output resourceGroupOutput string = resourceGroup().name
output webAppNameOutput string = webAppName
output registryNameOutput string = containerRegistry.name
output registryLoginServerOutput string = containerRegistry.properties.loginServer
output registryPasswordOutput string = listCredentials(containerRegistry.id, containerRegistry.apiVersion).passwords[0].value
