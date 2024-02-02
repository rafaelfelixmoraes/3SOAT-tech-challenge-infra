resource "azurerm_function_app" "example" {
  name                      = "example-function-app"
  resource_group_name       = azurerm_resource_group.example.name
  location                  = azurerm_resource_group.example.location
  app_service_plan_id       = azurerm_app_service_plan.example.id
  storage_account_name      = azurerm_storage_account.example.name
  storage_account_access_key = azurerm_storage_account.example.primary_access_key
  version                   = "~3"

  app_settings = {
    "FUNCTIONS_WORKER_RUNTIME" = "node"
  }
}

resource "azurerm_app_service_plan" "example" {
  name                = "example-app-service-plan"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  kind                = "FunctionApp"

  sku {
    tier = "Dynamic"
    size = "Y1"
  }
}

resource "azurerm_storage_account" "example" {
  name                     = "examplestorageaccount"
  resource_group_name      = azurerm_resource_group.example.name
  location                 = azurerm_resource_group.example.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_function_app_blob_storage" "example" {
  name                      = "example-blob-storage"
  storage_account_name      = azurerm_storage_account.example.name
  storage_account_access_key = azurerm_storage_account.example.primary_access_key
}

resource "azurerm_storage_account_function_app" "example" {
  storage_account_name = azurerm_storage_account.example.name
  function_app_name    = azurerm_function_app.example.name
}

resource "azurerm_function_app_zip" "example" {
  function_app_id = azurerm_function_app.example.id
  content         = "path/to/your/function_code.zip"  # Update with your actual zip file path
}

output "function_name" {
  value = azurerm_function_app.example.id
}