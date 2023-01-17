data "terraform_remote_state" "aks" {
  backend = "azurerm"

  config = {
    resource_group_name  = "terraform_backend_rg"
    container_name       = "backend"
    storage_account_name = "storebackend124"
    key                  = "kubernetes-stack.json"
  }
}

data "terraform_remote_state" "db" {
  backend = "azurerm"

  config = {
    resource_group_name  = "terraform_backend_rg"
    container_name       = "backend"
    storage_account_name = "storebackend124"
    key                  = "database-stack.json"
  }
}

resource "helm_release" "application" {
    name = "application"
    chart = "../charts/application"
    set {
      name = "gateway.deployment.jwt"
      value = var.jwt_secret
    }
    set {
      name = "authentication.deployment.jwt"
      value = var.jwt_secret
    }

    set {
      name = "authentication.deplyment.DB_HOST"
      value = data.terraform_remote_state.db.outputs.database-service-name
    }

    set {
      name = "authentication.deplyment.DB_PORT"
      value = data.terraform_remote_state.db.outputs.database-port
    }

    set {
      name = "authentication.deplyment.DB_NAME"
      value = data.terraform_remote_state.db.outputs.database-name
    }

    set {
      name = "authentication.deplyment.DB_USER"
      value = data.terraform_remote_state.db.outputs.database-username
    }

    set {
      name = "authentication.deplyment.DB_PASSWD"
      value = data.terraform_remote_state.db.outputs.database-password
    }

    set {
      name = "posts.deplyment.DB_HOST"
      value = data.terraform_remote_state.db.outputs.database-service-name
    }

    set {
      name = "posts.deplyment.DB_PORT"
      value = data.terraform_remote_state.db.outputs.database-port
    }

    set {
      name = "posts.deplyment.DB_NAME"
      value = data.terraform_remote_state.db.outputs.database-name
    }

    set {
      name = "posts.deplyment.DB_USER"
      value = data.terraform_remote_state.db.outputs.database-username
    }

    set {
      name = "posts.deplyment.DB_PASSWD"
      value = data.terraform_remote_state.db.outputs.database-password
    }

}