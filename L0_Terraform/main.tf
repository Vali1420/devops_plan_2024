module "vnet"{
    source="./modules/vnet"
    resource_group_location = var.resource_group_location
    resource_group_name = var.resource_group_name
}