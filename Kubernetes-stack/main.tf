resource "azurerm_resource_group" "barbershop-rg" {
  name = "barber-shop-resource-group"
  location = "France Central"
}

resource "azurerm_kubernetes_cluster" "barbershop-cluster" {
  name = "barbershop-cluster"
  location = azurerm_resource_group.barbershop-rg.location
  resource_group_name = azurerm_resource_group.barbershop-rg.name
  dns_prefix = "barber"
  sku_tier = "Free"

  default_node_pool {
    name = "default"
    node_count = 1
    vm_size = "standard_ds2_v2"
  }

  identity {
    type = "SystemAssigned"
  }
}