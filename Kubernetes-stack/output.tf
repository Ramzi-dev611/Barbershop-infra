output "kube_config" {
  value     = azurerm_kubernetes_cluster.barbershop-cluster.kube_config
  sensitive = true
}