module "vnet"{
    source="./modules/vnet"
    vnet_name = var.vnet_name
    resource_group_location = var.resource_group_location
    resource_group_name = var.resource_group_name
}

module "acr"{
    source="./modules/acr"
    resource_group_location = var.resource_group_location
    resource_group_name = var.resource_group_name
}

module "mysql"{
    source="./modules/db_mysql"
    resource_group_location = var.resource_group_location
    resource_group_name = var.resource_group_name
    azure_virtual_network_id = module.vnet.vnet_id
    depends_on=[module.vnet]
}