resource "azurerm_virtual_network" "example" {
  name                = "devops_plan_vnet"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  address_space       = ["10.0.0.0/16"]
}