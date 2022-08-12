output "application_id" {
  description = "Application/Client ID for new service principal"
  value       = azuread_application.autocloud.application_id
}

output "client_secret" {
  description = "Client secret for new service principal"
  value       = nonsensitive(azuread_application_password.autocloud.value)
  sensitive   = true
}

output "subritption_id" {
  description = "Subscription ID permissions attached to"
  value       = basename(data.azurerm_subscription.current.id)
}

output "tenant_id" {
  description = "Tenant ID for tenant service principal attached to"
  value       = data.azurerm_subscription.current.tenant_id
}
