output "Subritption_ID" {
  value = azurerm_subscription.current.id
}

output "Tenant_ID" {
  value = azurerm_subscription.current.tenant_id
}

output "Application_ID" {
  value = azuread_application.autocloud.application_id
}

output "Client_Secret" {
  value = nonsensitive(azuread_application_password.autocloud.value)
}
