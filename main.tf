resource "random_uuid" "admin" {
  count = var.enabled ? 1 : 0
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
    resource_app_id = "e406a681-f3d4-42a8-90b6-c2b029497af1" # Azure Storage

    resource_access {
      id   = "03e0da56-190b-40ad-a80c-ea378c433f7f" # user_impersonation
      type = "Scope"
    }
  }

  required_resource_access {
    resource_app_id = "00000003-0000-0000-c000-000000000000" # Microsoft Graph

    resource_access {
      id   = "e4c9e354-4dc5-45b8-9e7c-e1393b0b1a20" # AuditLog.Read.All
      type = "Scope"
    }
    resource_access {
      id   = "06da0dbc-49e2-44d2-8312-53f166ab848a" # Directory.Read.All
      type = "Scope"
    }
    resource_access {
      id   = "572fea84-0151-49b2-9301-11cb16974376" # Policy.Read.All
      type = "Scope"
    }
    resource_access {
      id   = "e1fe6dd8-ba31-4d61-89e7-88639da4683d" # User.Read
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

# Grant admin consent to for the default directory
resource "null_resource" "grant-admin" {
  count = var.enabled && var.grant_admin_consent ? 1 : 0
  provisioner "local-exec" {
    command = "az ad app permission admin-consent --id ${azuread_application.autocloud[0].application_id}"
  }
  depends_on = [
    azurerm_role_assignment.autocloud_reader[0],
    azurerm_role_assignment.autocloud_security_reader[0]
  ]

  triggers = {
    application_id = azuread_application.autocloud[0].application_id
  }
}