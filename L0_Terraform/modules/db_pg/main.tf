resource "azurerm_subnet" "default" {
  name                 = "postgres-subnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.vnet_name
  address_prefixes     = ["10.0.1.0/24"]
  service_endpoints    = ["Microsoft.Storage"]

  delegation {
    name = "fs"
    service_delegation {
      name = "Microsoft.DBforPostgreSQL/flexibleServers"
      actions = [
        "Microsoft.Network/virtualNetworks/subnets/join/action",
      ]
    }
  }
}

resource "azurerm_private_dns_zone" "default" {
  name                = "carwebsql2024.postgres.database.azure.com"
  resource_group_name = var.resource_group_name
}

resource "azurerm_private_dns_zone_virtual_network_link" "default" {
  name                  = "postgrescarwebvirtualnetworklink.com"
  private_dns_zone_name = azurerm_private_dns_zone.default.name
  virtual_network_id    = var.azure_virtual_network_id
  resource_group_name   = var.resource_group_name
}

resource "azurerm_postgresql_flexible_server" "default" {
  name                   = "postgrescarwebflexibleserver12"
  resource_group_name    = var.resource_group_name
  location               = var.resource_group_location
  version                = "13"
  delegated_subnet_id    = azurerm_subnet.default.id
  private_dns_zone_id    = azurerm_private_dns_zone.default.id
  administrator_login    = var.postgres_admin
  administrator_password = var.postgres_password
  storage_mb             = 32768
  sku_name   = "B_Standard_B1ms"
  backup_retention_days  = 7
  
  depends_on = [azurerm_private_dns_zone_virtual_network_link.default]
}