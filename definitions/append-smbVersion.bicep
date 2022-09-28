targetScope = 'subscription'

resource policy 'Microsoft.Authorization/policyDefinitions@2021-06-01' = {
  name: 'SMB-Version-StorageAccount-FileServices-APPEND'
  properties: {
    description: 'SMB Version for Storage Account File Services. Append Storage Account File services SMB version v3.0 or v3.0 and v3.11'
    displayName: 'Append SMB Version for Storage Account File Services'
    mode: 'All'
    metadata: {
      category: 'Storage'
    }
    parameters: {
      smbVersions: {
        type: 'String'
        defaultValue: 'SMB3.0;SMB3.1.1;'
        allowedValues: [
          'SMB3.0;SMB3.1.1;'
          'SMB3.1.1;'
        ]
        metadata: {
          description: 'SMB Version (SMB3.1.1 and/or SMB3.0)'
          displayName: 'SMB Versions'
        }
      }
      effect: {
        type: 'String'
        metadata: {
          displayName: 'Effect'
          description: 'Enable or disable the execution of the policy.'
        }
        allowedValues: [
          'append'
          'disabled'
        ]
        defaultValue: 'append'
      }
    }
    policyRule: {
      if: {
        allof: [
          {
            field: 'type'
            equals: 'Microsoft.Storage/storageAccounts/fileServices'
          }
          {
            field: 'Microsoft.Storage/storageAccounts/fileServices/protocolSettings.smb.versions'
            exists: false
          }
        ]
      }
      then: {
        effect: '[parameters(\'effect\')]'
        details: [
          {
            field: 'Microsoft.Storage/storageAccounts/fileServices/protocolSettings.smb.versions'
            value: '[parameters(\'smbVersions\')]'
          }
        ]
      }
    }
  }
}

output policyID string = policy.id
