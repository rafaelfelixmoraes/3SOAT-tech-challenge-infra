resource "azurerm_container_registry" "acr" {
  name                = var.acr_name
  resource_group_name = var.resource_group_name
  location            = var.region
  sku                 = var.sku_type
  admin_enabled       = false
}