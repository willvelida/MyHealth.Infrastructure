param serviceBusName string
param serviceBusLocation string
param activityQueueName string
param sleepQueueName string
param bodyQueueName string
param nutritionQueueName string
param exceptionQueueName string
param maxDeliveryCount int 

resource myhealthservicebus 'Microsoft.ServiceBus/namespaces@2021-06-01-preview' = {
  name: serviceBusName
  location: serviceBusLocation
  tags: {
    ApplicationName: 'MyHealth'
  }
  sku: {
    capacity: 1
    name: 'Basic'
    tier: 'Basic'
  }
  identity: {
    type: 'SystemAssigned'
  }

  resource activityQueue 'queues@2021-06-01-preview' = {
    name: activityQueueName
    properties: {
      deadLetteringOnMessageExpiration: true
      maxDeliveryCount: maxDeliveryCount
    }
  }

  resource sleepQueue 'queues@2021-06-01-preview' = {
    name: sleepQueueName
    properties: {
      deadLetteringOnMessageExpiration: true
      maxDeliveryCount: maxDeliveryCount
    }
  }

  resource bodyQueue 'queues@2021-06-01-preview' = {
    name: bodyQueueName
    properties: {
      deadLetteringOnMessageExpiration: true
      maxDeliveryCount: maxDeliveryCount
    }
  }

  resource nutritionQueue 'queues@2021-06-01-preview' = {
    name: nutritionQueueName
    properties: {
      deadLetteringOnMessageExpiration: true
      maxDeliveryCount: maxDeliveryCount
    }
  }

  resource exceptionQueue 'queues@2021-06-01-preview' = {
    name: exceptionQueueName
    properties: {
      deadLetteringOnMessageExpiration: true
      maxDeliveryCount: maxDeliveryCount
    }
  }
}
