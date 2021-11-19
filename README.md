AutoCloud Azure Enterprise Application
======================================

## Overview

Description of what the module does

This module provisions an Azure Application Registration and an Enterprise Application (Service Principal) granting cross account read-only access rights for AutoCloud's services to ingest your infrastructure.

## Specifications

* azuread_application - Cross Account Application Registration
* azuread_service_principal - Cross Account Service Principal
* azuread_application_password - Client Secret needed to authenticate with the Application Registration
* azurerm_role_assignment - Role Assignment of permissions to the Application

#### Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azuread"></a> [azuread](#requirement_azuread) | 2.7.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement_azurerm) | 2.82.0 |

#### Providers

| Name | Version |
|------|---------|
| <a name="provider_azuread"></a> [azuread](#provider_azuread) | 2.7.0 |
| <a name="provider_azurerm"></a> [azurerm](#provider_azurerm) | 2.82.0 |
| <a name="provider_random"></a> [random](#provider_random) | n/a |

#### Modules

No modules.

#### Resources

| Name | Type |
|------|------|
| [azuread_application.autocloud](https://registry.terraform.io/providers/hashicorp/azuread/2.7.0/docs/resources/application) | resource |
| [azuread_application_password.autocloud](https://registry.terraform.io/providers/hashicorp/azuread/2.7.0/docs/resources/application_password) | resource |
| [azuread_service_principal.autocloud](https://registry.terraform.io/providers/hashicorp/azuread/2.7.0/docs/resources/service_principal) | resource |
| [azurerm_role_assignment.autocloud_reader](https://registry.terraform.io/providers/hashicorp/azurerm/2.82.0/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.autocloud_security_reader](https://registry.terraform.io/providers/hashicorp/azurerm/2.82.0/docs/resources/role_assignment) | resource |
| [random_uuid.admin](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/uuid) | resource |
| [azuread_client_config.current](https://registry.terraform.io/providers/hashicorp/azuread/2.7.0/docs/data-sources/client_config) | data source |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/2.82.0/docs/data-sources/client_config) | data source |
| [azurerm_subscription.current](https://registry.terraform.io/providers/hashicorp/azurerm/2.82.0/docs/data-sources/subscription) | data source |

#### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_tenant_id"></a> [tenant_id](#input_tenant_id) | Tenant Id | `string` | `""` | no |

#### Outputs

| Name | Description |
|------|-------------|
| <a name="output_Application_ID"></a> [Application_ID](#output_Application_ID) | n/a |
| <a name="output_Client_Secret"></a> [Client_Secret](#output_Client_Secret) | n/a |
| <a name="output_Subritption_ID"></a> [Subritption_ID](#output_Subritption_ID) | n/a |
| <a name="output_Tenant_ID"></a> [Tenant_ID](#output_Tenant_ID) | n/a |
