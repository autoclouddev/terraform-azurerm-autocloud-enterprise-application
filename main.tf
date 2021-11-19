resource "random_uuid" "admin" {}

resource "azuread_application" "autocloud" {
  display_name     = "autocloud-read-only"
  owners           = [data.azuread_client_config.current.object_id]
  sign_in_audience = "AzureADMultipleOrgs"

  api {
    mapped_claims_enabled          = true
    requested_access_token_version = 2

    oauth2_permission_scope {
      admin_consent_description  = "Administer the application"
      admin_consent_display_name = "Administer"
      enabled                    = false
      id                         = "06da0dbc-49e2-44d2-8312-53f166ab848a" # Directory.Read.All
      type                       = "Admin"
      value                      = "administer"
    }
  }

  required_resource_access {
    resource_app_id = "00000003-0000-0000-c000-000000000000" # Microsoft Graph

    resource_access {
      id   = "06da0dbc-49e2-44d2-8312-53f166ab848a" # Directory.Read.All
      type = "Scope"
    }
  }

  app_role {
    allowed_member_types = ["User", "Application"]
    description          = "Admins can manage roles and perform all task actions"
    display_name         = "Admin"
    enabled              = true
    id                   = random_uuid.admin.result
    value                = "Admin"
  }
}

resource "azuread_service_principal" "autocloud" {
  application_id               = azuread_application.autocloud.application_id
  app_role_assignment_required = false
  owners                       = [data.azuread_client_config.current.object_id]

  feature_tags {
    enterprise = true
    gallery    = true
  }
}

resource "azuread_application_password" "autocloud" {
  application_object_id = azuread_application.autocloud.object_id
}


resource "azurerm_role_assignment" "autocloud_reader" {
  scope                = data.azurerm_subscription.current.id
  role_definition_name = "Reader"
  principal_id         = azuread_service_principal.autocloud.object_id
}

resource "azurerm_role_assignment" "autocloud_security_reader" {
  scope                = data.azurerm_subscription.current.id
  role_definition_name = "Security Reader"
  principal_id         = azuread_service_principal.autocloud.object_id
}