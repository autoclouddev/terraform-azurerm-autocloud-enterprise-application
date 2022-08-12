AutoCloud Azure Enterprise Application
======================================

## Overview

Creates an Azure app regitration with the autocloud read_all permissions to grant access to the account

## Specifications

#### Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azuread"></a> [azuread](#requirement_azuread) | 2.27.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement_azurerm) | 3.18.0 |

#### Providers

| Name | Version |
|------|---------|
| <a name="provider_azuread"></a> [azuread](#provider_azuread) | 2.27.0 |
| <a name="provider_azurerm"></a> [azurerm](#provider_azurerm) | 3.18.0 |
| <a name="provider_random"></a> [random](#provider_random) | n/a |

#### Modules

No modules.

#### Resources

| Name | Type |
|------|------|
| [azuread_application.autocloud](https://registry.terraform.io/providers/hashicorp/azuread/2.27.0/docs/resources/application) | resource |
| [azuread_application_password.autocloud](https://registry.terraform.io/providers/hashicorp/azuread/2.27.0/docs/resources/application_password) | resource |
| [azuread_service_principal.autocloud](https://registry.terraform.io/providers/hashicorp/azuread/2.27.0/docs/resources/service_principal) | resource |
| [azurerm_role_assignment.autocloud_reader](https://registry.terraform.io/providers/hashicorp/azurerm/3.18.0/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.autocloud_security_reader](https://registry.terraform.io/providers/hashicorp/azurerm/3.18.0/docs/resources/role_assignment) | resource |
| [random_uuid.admin](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/uuid) | resource |
| [azuread_client_config.current](https://registry.terraform.io/providers/hashicorp/azuread/2.27.0/docs/data-sources/client_config) | data source |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/3.18.0/docs/data-sources/client_config) | data source |
| [azurerm_subscription.current](https://registry.terraform.io/providers/hashicorp/azurerm/3.18.0/docs/data-sources/subscription) | data source |

#### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_tenant_id"></a> [tenant_id](#input_tenant_id) | Tenant Id | `string` | `""` | no |

#### Outputs

| Name | Description |
|------|-------------|
| <a name="output_application_id"></a> [application_id](#output_application_id) | Application/Client ID for new service principal |
| <a name="output_client_secret"></a> [client_secret](#output_client_secret) | Client secret for new service principal |
| <a name="output_subritption_id"></a> [subritption_id](#output_subritption_id) | Subscription ID permissions attached to |
| <a name="output_tenant_id"></a> [tenant_id](#output_tenant_id) | Tenant ID for tenant service principal attached to |
