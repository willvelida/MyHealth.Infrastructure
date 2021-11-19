param accountName string
param accountLocation string
param myhealthDatabaseName string
param myhealthContainerName string
param containerThroughput int

resource myhealthcosmosaccount 'Microsoft.DocumentDB/databaseAccounts@2021-07-01-preview' = {
  name: accountName
  location: accountLocation
  tags: {
    ApplicationName: 'MyHealth'
  }
  kind: 'GlobalDocumentDB'
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    enableFreeTier: true
    enableAnalyticalStorage: true
    backupPolicy: {
      type: 'Continuous'
    }
    diagnosticLogSettings: {
      enableFullTextQuery: 'True'
    }
    consistencyPolicy: {
      defaultConsistencyLevel: 'Session'
    }
    createMode: 'Default'
    databaseAccountOfferType: 'Standard'
    locations: [
      {
        failoverPriority: 0
        isZoneRedundant: false
        locationName: accountLocation
      }
    ]
  }
}

resource myhealthdb 'Microsoft.DocumentDB/databaseAccounts/sqlDatabases@2021-07-01-preview' = {
  name: '${myhealthcosmosaccount.name}/${myhealthDatabaseName}'
  properties: {
    resource: {
      id: myhealthDatabaseName
    }
  }
}

module recordscontainer '../../modules/cosmosSqlContainer.bicep' = {
  name: 'Records'
  params: {
    databaseName: myhealthdb.name
    containerName: myhealthContainerName
    throughput: containerThroughput
    partitionKeyPath: '/DocumentType'
    includedIndexedPaths: [
      {
        path: '/*'
      }
    ]
    excludedIndexedPaths: [
    ]
  }
}
