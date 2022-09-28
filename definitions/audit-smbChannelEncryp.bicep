targetScope = 'subscription'

resource policy 'Microsoft.Authorization/policyDefinitions@2021-06-01' = {
  name: 'SMB-ChannelEncryption-StorageAccount-FileServices-AUDIT'
  properties: {
    description: 'SMB Channel encryption for Storage Account File Services. Audit SMB Channel encryption to: AES-128-GCM;AES-256-GCM or AES-128-CCM;AES-128-GCM;AES-256-GCM'
    displayName: 'Audit SMB Channel encryption for Storage Account File Services'
    mode: 'All'
    metadata: {
      category: 'Storage'
    }
    parameters: {
      smbChannelEncryption: {
        type: 'String'
        defaultValue: 'AES-128-GCM;AES-256-GCM;'
        allowedValues: [
          'AES-128-GCM;AES-256-GCM;'
          'AES-128-CCM;AES-128-GCM;AES-256-GCM;'
        ]
        metadata: {
          description: 'SMB channel encryption (AES-128-CCM;AES-128-GCM;AES-256-GCM)'
          displayName: 'SMB channel encryption'
        }
      }
      effect: {
        type: 'String'
        metadata: {
          displayName: 'Effect'
          description: 'Enable or disable the execution of the policy.'
        }
        allowedValues: [
          'auditIfNotExists'
          'disabled'
        ]
        defaultValue: 'auditIfNotExists'
      }
    }
    policyRule: {
      if: {
        allof: [
          {
            field: 'type'
            equals: 'Microsoft.Storage/storageAccounts'
          }
        ]
      }
      then: {
        effect: '[parameters(\'effect\')]'
        details: {
          type: 'Microsoft.Storage/storageAccounts/fileServices'
          existenceCondition: {
            allof: [
              {
                field: 'Microsoft.Storage/storageAccounts/fileServices/protocolSettings.smb.channelEncryption'
                Equals: '[parameters(\'smbChannelEncryption\')]'
              }
            ]
          }
        }
      }
    }
  }
}

output policyID string = policy.id
