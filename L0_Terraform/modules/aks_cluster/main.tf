resource "azurerm_subnet" "default" {
  name                 = "aks-cluster"
  resource_group_name  = var.resource_group_name
  address_prefixes     = ["10.0.6.0/22"]
  virtual_network_name = var.vnet_name
}

resource "azurerm_kubernetes_cluster" "example" {
  name                = "akscarwebapplication12"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  dns_prefix          = "akscarwebapp12-dns"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "standard_b2s"
    vnet_subnet_id = azurerm_subnet.default.id

  }

  network_profile {
    network_plugin = "kubenet"
    service_cidr = "10.1.0.0/16"
    dns_service_ip = "10.1.0.10"
  }

  identity {
    type = "SystemAssigned"
  }
}