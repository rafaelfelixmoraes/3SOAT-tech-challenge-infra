resource "azurerm_postgresql_server" "tc-g8-postgres-server" {
  name                = "tc-g8-postgres-server"
  location            = var.region
  resource_group_name = var.resource_group_name

  administrator_login          = "psqladmin"
  administrator_login_password = "H@Sh1CoR3!"

  sku_name   = "B_Gen5_1"
  version    = "11"
  storage_mb = 5120

  backup_retention_days        = 7
  geo_redundant_backup_enabled = false
  auto_grow_enabled            = true

  public_network_access_enabled    = true # Is it true for education porposes. For security, it must be FALSE
  ssl_enforcement_enabled          = false # Is it false for education porposes. For security, it must be TRUE
  #ssl_minimal_tls_version_enforced = "TLS1_2"
  ssl_minimal_tls_version_enforced = "TLSEnforcementDisabled" # This is for education porposes.
}

resource "azurerm_postgresql_database" "tc-g8-postgres-db" {
  name                = "tc-g8-postgres-db"
  resource_group_name = var.resource_group_name
  server_name         = azurerm_postgresql_server.tc-g8-postgres-server.name
  charset             = "UTF8"
  collation           = "English_United States.1252"

  # Prevent the possibility of accidental data loss
  # In a real world scenario, that config is very important. But, for education purpouse, 
  # we don't add to able tf-destroy on local environment
  #lifecycle {
  #  prevent_destroy = true
  #}
}

resource "azurerm_postgresql_firewall_rule" "tc-g8-postgres-db-firewall-rule" {
  name                = "tc-g8-postgres-db-firewall-rule"
  resource_group_name = var.resource_group_name
  server_name         = azurerm_postgresql_server.tc-g8-postgres-server.name

  # For education purpouse, we set a range that include all ip addresses, to able local pgAdmin connection
  # But, in a real world cenario, this is a very bad pratice
  start_ip_address    = "0.0.0.0"
  end_ip_address      = "255.255.255.255"
}