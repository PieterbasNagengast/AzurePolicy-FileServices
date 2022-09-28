targetScope = 'subscription'

resource policy 'Microsoft.Authorization/policyDefinitions@2021-06-01' = {
  name: 'SMB-AuhtenticationMethods-StorageAccount-FileServices-AUDIT'
  properties: {
    description: 'SMB Authentication methods for Storage Account File Services. Audit SMB Authentication methods to: NTLMv2, Kerberos or NTLMv2 and Kerberos'
    displayName: 'Audit SMB Authentication methods for Storage Account File Services'
    mode: 'All'
    metadata: {
      category: 'Storage'
    }
    parameters: {
      smbAuthMethods: {
        type: 'String'
        defaultValue: 'Kerberos;'
        allowedValues: [
          'NTLMv2;'
          'NTLMv2;Kerberos;'
          'Kerberos;'
        ]
        metadata: {
          description: 'SMB authentication methods (NTLMv2 and/or Kerberos)'
          displayName: 'SMB authentication methods'
        }
      }
      effect: {
        type: 'String'
        metadata: {
          displayName: 'Effect'
          description: 'Enable or disable the execution of the policy.'
        }
        allowedValues: [
          'audit'
          'disabled'
        ]
        defaultValue: 'audit'
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
            field: 'Microsoft.Storage/storageAccounts/fileServices/protocolSettings.smb.authenticationMethods'
            notEquals: '[parameters(\'smbAuthMethods\')]'
          }
        ]
      }
      then: {
        effect: '[parameters(\'effect\')]'
      }
    }
  }
}

output policyID string = policy.id
