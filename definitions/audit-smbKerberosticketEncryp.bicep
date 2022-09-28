targetScope = 'subscription'

resource policy 'Microsoft.Authorization/policyDefinitions@2021-06-01' = {
  name: 'SMB-KerberosTicketEncryption-StorageAccount-FileServices-AUDIT'
  properties: {
    description: 'SMB Kerberos Ticket encryption for Storage Account File Services. Audit SMB Ticket encryption to: RC4-HMAC and/or AES-256; '
    displayName: 'Audit SMB Kerberos Ticket encryption for Storage Account File Services'
    mode: 'All'
    metadata: {
      category: 'Storage'
    }
    parameters: {
      smbKerberosTicketEncryption: {
        type: 'String'
        defaultValue: 'AES-256;'
        allowedValues: [
          'RC4-HMAC;AES-256;'
          'AES-256;'
        ]
        metadata: {
          description: 'SMB kerberos ticket encryption (NTLMv2 and/or Kerberos)'
          displayName: 'SMB kerberos ticket encryption'
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
            field: 'Microsoft.Storage/storageAccounts/fileServices/protocolSettings.smb.kerberosTicketEncryption'
            notEquals: '[parameters(\'smbKerberosTicketEncryption\')]'
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
