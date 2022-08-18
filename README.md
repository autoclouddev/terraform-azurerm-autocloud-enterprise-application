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

#### Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azuread"></a> [azuread](#requirement_azuread) | 2.27.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement_azurerm) | 3.18.0 |
| <a name="requirement_null"></a> [null](#requirement_null) | 3.1.1 |
| <a name="requirement_random"></a> [random](#requirement_random) | 3.3.2 |

#### Providers

| Name | Version |
|------|---------|
| <a name="provider_azuread"></a> [azuread](#provider_azuread) | 2.27.0 |
| <a name="provider_azurerm"></a> [azurerm](#provider_azurerm) | 3.18.0 |
| <a name="provider_null"></a> [null](#provider_null) | 3.1.1 |
| <a name="provider_random"></a> [random](#provider_random) | 3.3.2 |

#### Modules

No modules.

#### Resources

| Name | Type |
|------|------|
| [azuread_application.autocloud](https://registry.terraform.io/providers/hashicorp/azuread/2.27.0/docs/resources/application) | resource |
| [azuread_application_password.autocloud](https://registry.terraform.io/providers/hashicorp/azuread/2.27.0/docs/resources/application_password) | resource |
| [azuread_service_principal.autocloud](https://registry.terraform.io/providers/hashicorp/azuread/2.27.0/docs/resources/service_principal) | resource |
| [azurerm_role_assignment.autocloud_management_group_reader](https://registry.terraform.io/providers/hashicorp/azurerm/3.18.0/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.autocloud_reader](https://registry.terraform.io/providers/hashicorp/azurerm/3.18.0/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.autocloud_security_reader](https://registry.terraform.io/providers/hashicorp/azurerm/3.18.0/docs/resources/role_assignment) | resource |
| [null_resource.grant-admin](https://registry.terraform.io/providers/hashicorp/null/3.1.1/docs/resources/resource) | resource |
| [random_uuid.admin](https://registry.terraform.io/providers/hashicorp/random/3.3.2/docs/resources/uuid) | resource |
| [azuread_application_published_app_ids.well_known](https://registry.terraform.io/providers/hashicorp/azuread/2.27.0/docs/data-sources/application_published_app_ids) | data source |
| [azuread_client_config.current](https://registry.terraform.io/providers/hashicorp/azuread/2.27.0/docs/data-sources/client_config) | data source |
| [azuread_service_principal.azurestorage](https://registry.terraform.io/providers/hashicorp/azuread/2.27.0/docs/data-sources/service_principal) | data source |
| [azuread_service_principal.msgraph](https://registry.terraform.io/providers/hashicorp/azuread/2.27.0/docs/data-sources/service_principal) | data source |
| [azurerm_subscription.current](https://registry.terraform.io/providers/hashicorp/azurerm/3.18.0/docs/data-sources/subscription) | data source |

#### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_enabled"></a> [enabled](#input_enabled) | Set to false to prevent the module from creating any resources | `bool` | `true` | no |
| <a name="input_grant_admin_consent"></a> [grant_admin_consent](#input_grant_admin_consent) | Set to false to prevent the module from granting admin consent | `bool` | `true` | no |
| <a name="input_tenant_id"></a> [tenant_id](#input_tenant_id) | Tenant Id | `string` | `""` | no |

#### Outputs

| Name | Description |
|------|-------------|
| <a name="output_application_id"></a> [application_id](#output_application_id) | Application/Client ID for new service principal |
| <a name="output_client_secret"></a> [client_secret](#output_client_secret) | Client secret for new service principal |
| <a name="output_subritption_id"></a> [subritption_id](#output_subritption_id) | Subscription ID permissions attached to |
| <a name="output_tenant_id"></a> [tenant_id](#output_tenant_id) | Tenant ID for tenant service principal attached to |
