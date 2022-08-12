terraform {
  required_providers {
    azuread = {
      source  = "hashicorp/azuread"
      version = "2.27.0"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.18.0"
    }
    null = {
      source  = "hashicorp/null"
      version = "3.1.1"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.3.2"
    }
  }
}
