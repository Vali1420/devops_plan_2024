resource "azurerm_subnet" "default" {
  name                 = "mysql-subnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.vnet_name
  address_prefixes     = ["10.0.0.0/24"]
  service_endpoints    = ["Microsoft.Storage"]
}

resource "azurerm_private_dns_zone" "default" {
  name                = "carwebsql2024.mysql.database.azure.com"
  resource_group_name = var.resource_group_name
}

resource "azurerm_private_dns_zone_virtual_network_link" "default" {
  name                  = "carwebvirtualnetworklink.com"
  private_dns_zone_name = azurerm_private_dns_zone.default.name
  virtual_network_id    = var.azure_virtual_network_id
  resource_group_name   = var.resource_group_name
}

resource "azurerm_mysql_flexible_server" "default" {
  name                   = "carwebmysqlflexibleserver12"
  resource_group_name    = var.resource_group_name
  location               = var.resource_group_location
  administrator_login    = var.mysql_admin
  administrator_password = var.mysql_password
  backup_retention_days  = 7
  delegated_subnet_id    = azurerm_subnet.default.id
  private_dns_zone_id    = azurerm_private_dns_zone.default.id
  sku_name               = "B_Standard_B1ms"
  version                = "8.0.21"

  maintenance_window {
    day_of_week  = 0
    start_hour   = 8
    start_minute = 0
  }

  storage {
    iops    = 360
    size_gb = 20
  }

   depends_on = [azurerm_private_dns_zone_virtual_network_link.default]
}