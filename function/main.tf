# Create a resource group
resource "azurerm_resource_group" "tc-g8-resource-group" {
  name     = "tc-g8-resources"
  location = var.region
}

# Create a storage account
resource "azurerm_storage_account" "tc-g8-storage-account" {
  name                     = "g8fiaptc"
  resource_group_name      = azurerm_resource_group.tc-g8-resource-group.name
  location                 = azurerm_resource_group.tc-g8-resource-group.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind             = "Storage"
}

# Create a service plan
resource "azurerm_service_plan" "tc-g8-service-plan" {
  name                = "tc-g8-service-plan"
  location            = azurerm_resource_group.tc-g8-resource-group.location
  resource_group_name = azurerm_resource_group.tc-g8-resource-group.name
  os_type             = "Linux"
  sku_name            = "Y1"
}

# Create a linux function app
resource "azurerm_linux_function_app" "tc-g8-function-app" {
  name                      = "tc-g8-function-app"
  resource_group_name       = azurerm_resource_group.tc-g8-resource-group.name
  location                  = azurerm_resource_group.tc-g8-resource-group.location
  service_plan_id           = azurerm_service_plan.tc-g8-service-plan.id
  
  storage_account_name      = azurerm_storage_account.tc-g8-storage-account.name
  storage_account_access_key = azurerm_storage_account.tc-g8-storage-account.primary_access_key

  tags = var.tags

  app_settings = {
    "FUNCTIONS_WORKER_RUNTIME" = "node"
  }

  site_config {
    application_stack {
      node_version = "18"
    }
    
  }
}

# Create a httpTrigger function app with custom source code
resource "azurerm_function_app_function" "tc-g8-app-function" {
  name            = "tc-g8-app-function" 
  function_app_id = azurerm_linux_function_app.tc-g8-function-app.id
  language        = "Javascript"

  file {
    name = "index.js"
    content = file("./azure_function/src/functions/index.js")
  }

  file {
    name = "host.json"
    content = file("./azure_function/host.json")
  }

  config_json = jsonencode({
    "bindings" = [
      {
        "authLevel" = "function"
        "direction" = "in"
        "name" = "req"
        "type" = "httpTrigger"
        "methods" = [
          "get",
          "post",
        ]
      },
      {
        "direction" = "out"
        "name"      = "res"
        "type"      = "http"
      },
    ]
  })
}

# Set a output after execution
output "function_name" {
  value = azurerm_linux_function_app.tc-g8-function-app.id
}