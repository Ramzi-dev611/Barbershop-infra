output "database-service-name" {
  description = "the host that will be used by the application for the db"
  value = "database-postgresql"
}

output "database-username" {
  description = "the username that will be used by the application for the db"
  value = var.database_username
}

output "database-password" {
  description = "the password that will be used by the application for the db"
  value = var.database_password
  sensitive = true
}

output "database-name" {
  description = "the host that will be used by the application for the db"
  value = var.database_name
}

output "database-port" {
  description = "the port that will be used by the application for the db"
  value = 5432
}