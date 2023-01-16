data "terraform_remote_state" "aks" {
  backend = "azurerm"

  config = {
    resource_group_name  = "terraform_backend_rg"
    container_name       = "backend"
    storage_account_name = "storebackend124"
    key                  = "kubernetes-stack.json"
  }
}

resource "helm_release" "application" {
    name = "application"
    chart = "../../barber-shop/charts"
}