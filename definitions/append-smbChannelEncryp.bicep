targetScope = 'subscription'

resource policy 'Microsoft.Authorization/policyDefinitions@2021-06-01' = {
  name: 'SMB-ChannelEncryption-StorageAccount-FileServices-APPEND'
  properties: {
    description: 'SMB Channel encryption for Storage Account File Services. Append SMB Channel encryption to: AES-128-GCM;AES-256-GCM or AES-128-CCM;AES-128-GCM;AES-256-GCM'
    displayName: 'Append SMB Channel encryption for Storage Account File Services'
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
            field: 'Microsoft.Storage/storageAccounts/fileServices/protocolSettings.smb.channelEncryption'
            exists: false
          }
        ]
      }
      then: {
        effect: '[parameters(\'effect\')]'
        details: [
          {
            field: 'Microsoft.Storage/storageAccounts/fileServices/protocolSettings.smb.channelEncryption'
            value: '[parameters(\'smbChannelEncryption\')]'
          }
        ]
      }
    }
  }
}

output policyID string = policy.id
