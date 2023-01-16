resource "azurerm_resource_group" "database-rg" {
  name = "database_resource-group"
  location = "France Central"
}

resource "azurerm_postgresql_server" "database-server" {
  name                = "postgresql-server"
  location            = azurerm_resource_group.database-rg.location
  resource_group_name = azurerm_resource_group.database-rg.name

  sku_name = "B_Gen5_2"

  storage_mb                   = 5120
  backup_retention_days        = 7
  geo_redundant_backup_enabled = false
  auto_grow_enabled            = true

  administrator_login          = "barbershopDbUser"
  administrator_login_password = "barbershopDbPasswd"
  public_network_access_enabled = true
  version                      = "9.5"
  ssl_enforcement_enabled      = true
}

resource "azurerm_postgresql_database" "database" {
  name                = "barbershopDB"
  resource_group_name = azurerm_resource_group.database-rg.name
  server_name         = azurerm_postgresql_server.database-server.name
  charset             = "UTF8"
  collation           = "English_United States.1252"
}