# Initialize Azure provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3"
    }
  }

}

# Config provider
provider "azurerm" {
  skip_provider_registration = true # This is only required when the User, Service Principal, or Identity running Terraform lacks the permissions to register Azure Resource Providers.
  features {}
}

# Create a resource group
resource "azurerm_resource_group" "tc-g8-resource-group" {
  name     = var.resource_group_name
  location = var.region
}

# Create Function Module
module "function" {
  source     = "./function"
  depends_on = [azurerm_resource_group.tc-g8-resource-group]
}

# Create Postgres-DB Module
module "postgres" {
  source     = "./postgres_db"
  depends_on = [module.function]
}

# Create ACR Module
module "acr" {
  source     = "./acr"
  depends_on = [module.postgres]
}

# Create Cluster Module
module "cluster" {
  source     = "./cluster"
  depends_on = [module.acr]
}

# Set a output after execution
output "function_name" {
  value = module.function.function_name
}
