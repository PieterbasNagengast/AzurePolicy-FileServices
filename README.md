# Azure Policy: Storage Account File Services SMB settings (Append and auditIfNotExists)

## Description

Azure custom Policy definitions (and/or initiative) to Audit and/or Append Azure Storage Account File Services SMB settings:
- SMB Auhtentication methods
- SMB Version
- SMB Channel Encryption
- SMB Kerberos Ticket Encryption

## Background/Use case

Used in scenraio's where you want to Audit the SMB Settings for existing Storage Account(s) and/or set SMB settings for newly created Azure Storage Accounts.

- Initiative includes 8 policy definitions:
  - 4x auditIfNotExists policy definitions:
    - SMB Auhtentication methods
    - SMB Version
    - SMB Channel Encryption
    - SMB Kerberos Ticket Encryption
  - 4x Append policy definitions:
    - SMB Auhtentication methods
    - SMB Version
    - SMB Channel Encryption
    - SMB Kerberos Ticket Encryption

## Deploy

Deploy Policy initiative to Management Group or Subscription level:

| Description | Bicep Template |
|---|---|
| Deploy to Azure Management Group| [![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FPieterbasNagengast%2FAzurePolicy-FileServices%2Fmain%2FARM%2Fmanagementgroup.json)|
| Deploy to Azure Subscription | [![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FPieterbasNagengast%2FAzurePolicy-FileServices%2Fmain%2FARM%2Fsubscription.json)|