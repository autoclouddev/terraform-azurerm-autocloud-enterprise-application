resource "random_uuid" "admin" {
  count = var.enabled ? 1 : 0
}

data "azuread_service_principal" "azurestorage" {
  application_id = data.azuread_application_published_app_ids.well_known.result.AzureStorage
}

data "azuread_service_principal" "msgraph" {
  application_id = data.azuread_application_published_app_ids.well_known.result.MicrosoftGraph
}

# Create an App Registration with the required resources access
resource "azuread_application" "autocloud" {
  count            = var.enabled ? 1 : 0
  display_name     = "autocloud-read-only"
  owners           = [data.azuread_client_config.current.object_id]
  sign_in_audience = "AzureADMultipleOrgs"

  api {
    mapped_claims_enabled          = true
    requested_access_token_version = 2

  }

  required_resource_access {
    resource_app_id = data.azuread_application_published_app_ids.well_known.result.AzureStorage # Azure Storage

    resource_access {
      id   = data.azuread_service_principal.azurestorage.oauth2_permission_scope_ids["user_impersonation"] # user_impersonation
      type = "Scope"
    }
  }

  required_resource_access {
    resource_app_id = data.azuread_application_published_app_ids.well_known.result.MicrosoftGraph # Microsoft Graph

    resource_access {
      id   = data.azuread_service_principal.msgraph.oauth2_permission_scope_ids["AuditLog.Read.All"] # AuditLog.Read.All
      type = "Scope"
    }
    resource_access {
      id   = data.azuread_service_principal.msgraph.oauth2_permission_scope_ids["Directory.Read.All"] # Directory.Read.All
      type = "Scope"
    }
    resource_access {
      id   = data.azuread_service_principal.msgraph.oauth2_permission_scope_ids["Policy.Read.All"] # Policy.Read.All
      type = "Scope"
    }
    resource_access {
      id   = data.azuread_service_principal.msgraph.oauth2_permission_scope_ids["User.Read"] # User.Read
      type = "Scope"
    }

  }
  app_role {
    allowed_member_types = ["User", "Application"]
    description          = "Admins can manage roles and perform all task actions"
    display_name         = "Admin"
    enabled              = true
    id                   = random_uuid.admin[0].result
    value                = "Admin"
  }

  depends_on = [
    data.azuread_service_principal.azurestorage,
    data.azuread_service_principal.msgraph
  ]
}

# Create a Service Principal from the app registration
resource "azuread_service_principal" "autocloud" {
  count                        = var.enabled ? 1 : 0
  application_id               = azuread_application.autocloud[0].application_id
  app_role_assignment_required = false
  owners                       = [data.azuread_client_config.current.object_id]
}

resource "azuread_application_password" "autocloud" {
  count                 = var.enabled ? 1 : 0
  application_object_id = azuread_application.autocloud[0].object_id
}

# Perform role assignment as eader and Securirty Reader on the subscription
resource "azurerm_role_assignment" "autocloud_reader" {
  count                = var.enabled ? 1 : 0
  scope                = data.azurerm_subscription.current.id
  role_definition_name = "Reader"
  principal_id         = azuread_service_principal.autocloud[0].object_id
}

resource "azurerm_role_assignment" "autocloud_security_reader" {
  count                = var.enabled ? 1 : 0
  scope                = data.azurerm_subscription.current.id
  role_definition_name = "Security Reader"
  principal_id         = azuread_service_principal.autocloud[0].object_id
}

resource "azurerm_role_assignment" "autocloud_management_group_reader" {
  count                = var.enabled ? 1 : 0
  scope                = data.azurerm_subscription.current.id
  role_definition_name = "Management Group Reader"
  principal_id         = azuread_service_principal.autocloud[0].object_id
}

resource "azurerm_role_assignment" "autocloud_billing_reader" {
  count                = var.enabled ? 1 : 0
  scope                = data.azurerm_subscription.current.id
  role_definition_name = "Billing Reader"
  principal_id         = azuread_service_principal.autocloud[0].object_id
}

# Grant admin consent to the default directory
resource "null_resource" "grant-admin" {
  count = var.enabled && var.grant_admin_consent ? 1 : 0
  provisioner "local-exec" {
    command = "az ad app permission admin-consent --id ${azuread_application.autocloud[0].application_id}"
  }
  depends_on = [
    azurerm_role_assignment.autocloud_reader[0],
    azurerm_role_assignment.autocloud_security_reader[0],
    azurerm_role_assignment.autocloud_management_group_reader[0]
  ]

  triggers = {
    application_id = azuread_application.autocloud[0].application_id
  }
}