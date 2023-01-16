output "database-server-name" {
  value = azurerm_postgresql_database.database.server_name
}

output "database-server-pass" {
  value = azurerm_postgresql_server.database-server.administrator_login_password
  sensitive = true
}