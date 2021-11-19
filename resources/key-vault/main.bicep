param keyVaultName string
param keyVaultLocation string
param keyVaultTenantId string
param keyVaultObjectId string

resource myhealthkv 'Microsoft.KeyVault/vaults@2021-06-01-preview' = {
  name: keyVaultName
  location: keyVaultLocation
  tags: {
    ApplicationName: 'MyHealth'
  }
  properties: {
    accessPolicies: [
      {
        objectId: keyVaultObjectId
        tenantId: keyVaultTenantId
        permissions: {
          certificates: []
          keys: [
            'get'
            'list'
            'delete'
            'recover'
            'create'
          ]
          secrets: [
            'get'
            'set'
            'list'
            'delete'
            'recover'
            'purge'
          ]
          storage: []
        }
      }
    ]
    enablePurgeProtection: true
    enabledForTemplateDeployment: true
    enabledForDeployment: true
    createMode: 'recover'
    softDeleteRetentionInDays: 7
    tenantId: keyVaultTenantId
    sku: {
      family: 'A'
      name: 'standard'
    }
  }
}
