output "namespace_id" {
  description = "namsepace ID"
  value       = kubernetes_namespace.prometheus_namespace.id
}