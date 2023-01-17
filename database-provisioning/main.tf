data "terraform_remote_state" "aks" {
  backend = "azurerm"

  config = {
    resource_group_name  = "terraform_backend_rg"
    container_name       = "backend"
    storage_account_name = "storebackend124"
    key                  = "kubernetes-stack.json"
  }
}

resource "kubernetes_persistent_volume" "database_persistance_volume" {
    metadata {
      name = "dbpvc"
    }
    spec {
        storage_class_name = "manual"
        capacity = {
            storage = "10Gi"
        }
        access_modes = ["ReadWriteMany"]
        persistent_volume_source {
             gce_persistent_disk {
                pd_name = "test-123"
            }
        }
    }
}

resource "kubernetes_persistent_volume_claim" "database_volume_claim" {
  metadata {
    name = "dbvlaim"
  }
  spec {
    storage_class_name = "manual"
    access_modes = ["ReadWriteMany"]
    resources {
      requests = {
        storage = "5Gi"
      }
    }
    volume_name = kubernetes_persistent_volume.database_persistance_volume.metadata.0.name
  }
}

resource "helm_release" "postgres_helm_release" {
  name = "database"
  repository = "https://charts.bitnami.com/bitnami"
  chart = "postgresql"
  set {
    name = "persistence.existingClaim"
    value = kubernetes_persistent_volume_claim.database_volume_claim.metadata.0.name
  }

  set {
    name = "volumePermissions.enabled"
    value = "true"
  }

  set {
    name = "postgresqlUsername"
    value = var.database_username
  }
  set {
    name = "postgresqlPassword"
    value = var.database_password
  }

  set {
    name = "postgresqlDatabase"
    value = var.database_name
  }
}