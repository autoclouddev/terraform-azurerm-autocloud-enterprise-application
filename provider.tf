provider "azurerm" {
  features {}
  tenant_id = var.tenant_id
}

provider "azuread" {
  tenant_id = var.tenant_id
}

