targetScope = 'subscription'

// Append Policy's
module smbVersionAppend 'definitions/append-smbVersion.bicep' = {
  name: 'Deploy-SMB-Version-Policy-Definition-Append'
}

module smbChannelEncrypAppend 'definitions/append-smbChannelEncryp.bicep' = {
  name: 'Deploy-SMB-ChannelEncryption-Policy-Definition-Append'
}

module smbKerberosTicketEncrypAppend 'definitions/append-smbKerberosticketEncryp.bicep' = {
  name: 'Deploy-SMB-KerberosTicketEncryption-Policy-Definition-Append'
}

module smbAuthMethodsAppend 'definitions/append-smbAuthMethods.bicep' = {
  name: 'Deploy-SMB-AuthenticationMethods-Policy-Definition-Append'
}

// Audit Policy's
module smbVersionAudit 'definitions/audit-smbVersion.bicep' = {
  name: 'Deploy-SMB-Version-Policy-Definition-Audit'
}

module smbChannelEncrypAudit 'definitions/audit-smbChannelEncryp.bicep' = {
  name: 'Deploy-SMB-ChannelEncryption-Policy-Definition-Audit'
}

module smbKerberosTicketEncrypAudit 'definitions/audit-smbKerberosticketEncryp.bicep' = {
  name: 'Deploy-SMB-KerberosTicketEncryption-Policy-Definition-Audit'
}

module smbAuthMethodsAudit 'definitions/audit-smbAuthMethods.bicep' = {
  name: 'Deploy-SMB-AuthenticationMethods-Policy-Definition-Audit'
}

//Policy Definition Set
resource smbPolicySet 'Microsoft.Authorization/policySetDefinitions@2021-06-01' = {
  name: 'SMB-StorageAccount-FileServices'
  properties: {
    description: 'Append and Audit SMB Settings for Storage Account File Services. Audits and Appends SMB Auhtentication Methods, SMB Versions, SMB Channel Encryption and SMB Keberos Ticket encryption. Append Policies sets SMB Settings for newly created Storage Accounts. Audit Policies audits existing Storage Account File Services SMB Settings.'
    displayName: 'Storage Account File services SMB Settings'
    metadata: {
      category: 'Storage'
    }
    parameters: {
      smbVeersions: {
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
      smbAppendEffect: {
        type: 'String'
        metadata: {
          displayName: 'SMB Effect for Append policy'
          description: 'Enable or disable the execution of the policy.'
        }
        allowedValues: [
          'append'
          'disabled'
        ]
        defaultValue: 'append'
      }
      smbAuditEffect: {
        type: 'String'
        metadata: {
          displayName: 'SMB Effect for Audit policy'
          description: 'Enable or disable the execution of the policy.'
        }
        allowedValues: [
          'audit'
          'disabled'
        ]
        defaultValue: 'audit'
      }
    }
    policyDefinitions: [
      {
        policyDefinitionId: smbVersionAppend.outputs.policyID
        parameters: {
          smbVersions: {
            value: '[parameters(\'smbVeersions\')]'
          }
          effect: {
            value: '[parameters(\'smbAppendEffect\')]'
          }
        }
      }
      {
        policyDefinitionId: smbChannelEncrypAppend.outputs.policyID
        parameters: {
          smbChannelEncryption: {
            value: '[parameters(\'smbChannelEncryption\')]'
          }
          effect: {
            value: '[parameters(\'smbAppendEffect\')]'
          }
        }
      }
      {
        policyDefinitionId: smbKerberosTicketEncrypAppend.outputs.policyID
        parameters: {
          smbKerberosTicketEncryption: {
            value: '[parameters(\'smbKerberosTicketEncryption\')]'
          }
          effect: {
            value: '[parameters(\'smbAppendEffect\')]'
          }
        }
      }
      {
        policyDefinitionId: smbAuthMethodsAppend.outputs.policyID
        parameters: {
          smbAuthMethods: {
            value: '[parameters(\'smbAuthMethods\')]'
          }
          effect: {
            value: '[parameters(\'smbAppendEffect\')]'
          }
        }
      }
      {
        policyDefinitionId: smbVersionAudit.outputs.policyID
        parameters: {
          smbVersions: {
            value: '[parameters(\'smbVeersions\')]'
          }
          effect: {
            value: '[parameters(\'smbAuditEffect\')]'
          }
        }
      }
      {
        policyDefinitionId: smbChannelEncrypAudit.outputs.policyID
        parameters: {
          smbChannelEncryption: {
            value: '[parameters(\'smbChannelEncryption\')]'
          }
          effect: {
            value: '[parameters(\'smbAuditEffect\')]'
          }
        }
      }
      {
        policyDefinitionId: smbKerberosTicketEncrypAudit.outputs.policyID
        parameters: {
          smbKerberosTicketEncryption: {
            value: '[parameters(\'smbKerberosTicketEncryption\')]'
          }
          effect: {
            value: '[parameters(\'smbAuditEffect\')]'
          }
        }
      }
      {
        policyDefinitionId: smbAuthMethodsAudit.outputs.policyID
        parameters: {
          smbAuthMethods: {
            value: '[parameters(\'smbAuthMethods\')]'
          }
          effect: {
            value: '[parameters(\'smbAuditEffect\')]'
          }
        }
      }      
    ]
  }
}

output PolicySetID string = smbPolicySet.id
