resource "azurerm_subnet" "default" {
  name                 = "aks-cluster-subnet"
  resource_group_name  = var.resource_group_name
  address_prefixes     = ["10.0.4.0/22"]
  virtual_network_name = var.vnet_name
}

resource "azurerm_kubernetes_cluster" "default" {
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

  identity {
   type = "SystemAssigned"
  }

  key_vault_secrets_provider {
   # update the secrets on a regular basis
   secret_rotation_enabled = true
  }

  network_profile {
    network_plugin = "kubenet"
    service_cidr = "10.1.0.0/16"
    dns_service_ip = "10.1.0.10"
  }
}

resource "azurerm_key_vault_access_policy" "vaultaccess" {
 key_vault_id = var.azure_key_vault_id
 tenant_id    = var.azure_key_vault_tenant
 object_id    = azurerm_kubernetes_cluster.default.key_vault_secrets_provider[0].secret_identity[0].object_id
 # cluster access to secrets should be read-only
 secret_permissions = [
   "Get", "List"
 ]
}