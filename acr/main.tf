terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.93.0"
    }
  }
}

provider "azurerm" {
  # Configuration options
  features {
    
  }
}

resource "azurerm_resource_group" "acr-resourge-group" {
  name     = var.resource_group_name
  location = var.region
}

resource "azurerm_container_registry" "acr" {
  name                = "acrrepository"
  resource_group_name = azurerm_resource_group.acr-resourge-group.name
  location            = azurerm_resource_group.acr-resourge-group.location
  sku                 = "Basic"
  admin_enabled       = false
}