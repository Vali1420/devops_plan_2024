resource "azurerm_subnet" "default" {
  name                 = "aks-cluster"
  resource_group_name  = var.resource_group_name
  address_prefix       = "10.0.4.0/22"
  virtual_network_name = var.vnet_name
}

resource "azurerm_kubernetes_cluster" "example" {
  name                = "aks-carwebapplication"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  dns_prefix          = "akscarwebapp12-dns"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard B2s"
    vnet_subnet_id = azurerm_subnet.default.id

  }

  identity {
    type = "SystemAssigned"
  }
}