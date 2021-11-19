param containerName string
param databaseName string
param partitionKeyPath string
param includedIndexedPaths array
param excludedIndexedPaths array
param throughput int 

resource sqlContainer 'Microsoft.DocumentDB/databaseAccounts/sqlDatabases/containers@2021-07-01-preview' = {
  name: '${databaseName}/${containerName}'
  properties: {
    resource: {
      id: containerName
      partitionKey: {
        paths: [
          partitionKeyPath
        ]
        kind: 'Hash'
      }
      indexingPolicy: {
        indexingMode: 'consistent'
        includedPaths: includedIndexedPaths
        excludedPaths: excludedIndexedPaths
      }
    }
    options: {
      throughput: throughput
    }
  }
}
