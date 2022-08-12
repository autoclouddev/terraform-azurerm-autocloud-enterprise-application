AutoCloud Azure Enterprise Application
======================================

## Overview

This module provisions an Azure Application Registration and an Enterprise Application (Service Principal) granting cross account read-only access rights for AutoCloud's services to ingest your infrastructure. Specifically it provisions the following permissions:

Microsoft Graph Permissions:

AuditLog.Read.All
Directory.Read.All
Policy.Read.All
User.Read

Azure Storage

user_impersonation

These permissions are required for AutoCloud to inventory and analyze the contents of the subscription. The values of the outputs will be needed for configuring access in AutoCloud. For more information, please refer to the [documentation](https://docs.autocloud.dev/azure-subscription#5Vdca)

## Specifications

* azuread_application - Cross Account Application Registration
* azuread_service_principal - Cross Account Service Principal
* azuread_application_password - Client Secret needed to authenticate with the Application Registration 
* azurerm_role_assignment - Role Assignment of permissions to the Application
* null_resource - To grant-admin consent for the default directory