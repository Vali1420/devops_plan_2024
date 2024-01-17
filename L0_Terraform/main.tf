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
    mysql_admin = var.mysql_admin
    mysql_password = var.mysql_password
    vnet_name = var.vnet_name
    azure_virtual_network_id = module.vnet.vnet_id
    depends_on=[module.vnet]
}

module "postgres"{
    source="./modules/db_pg"
    resource_group_location = var.resource_group_location
    resource_group_name = var.resource_group_name
    postgres_admin = var.postgres_admin
    postgres_password = var.postgres_password
    vnet_name = var.vnet_name
    azure_virtual_network_id = module.vnet.vnet_id
    depends_on=[module.vnet]
}

module "aks_cluster"{
    source="./modules/aks_cluster"
    resource_group_location = var.resource_group_location
    resource_group_name = var.resource_group_name
    vnet_name = var.vnet_name
}