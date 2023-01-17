data "terraform_remote_state" "aks" {
  backend = "azurerm"

  config = {
    resource_group_name  = "terraform_backend_rg"
    container_name       = "backend"
    storage_account_name = "storebackend124"
    key                  = "kubernetes-stack.json"
  }
}

resource "kubernetes_namespace" "prometheus_namespace" {
  metadata {
    labels = {
      environment = "production"
    }
    generate_name = "metrics-namespace-"
  }
}

resource "helm_release" "prometheus" {
    name = "prometheus"
    repository = "https://prometheus-community.github.io/helm-charts"
    chart = "prometheus"
    namespace = kubernetes_namespace.prometheus_namespace.id
}

resource "helm_release" "grafana" {
  name = "grafana"
  repository = "https://grafana.github.io/helm-charts"
  chart = "grafana"
  namespace = kubernetes_namespace.prometheus_namespace.id
  set {
    name = "ingress.enabled"
    value = true
  }
}

resource "helm_release" "datadog" {
  name = "datadog"
  repository = "https://helm.datadoghq.com"
  chart = "datadog"

  set {
    name  = "datadog.apiKey"
    value = var.datadog_api_key
  }

  set {
    name  = "datadog.site"
    value = var.datadog_site
  }

  set {
    name  = "datadog.logs.enabled"
    value = "true"
  }
  set {
    name  = "datadog.kubelet.tlsVerify"
    value = "false"
  }
  set {
    name  = "datadog.logs.containerCollectAll"
    value = "true"
  }
  
}