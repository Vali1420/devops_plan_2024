# module "vnet"{
#     source="./modules/vnet"
#     vnet_name = var.vnet_name
#     resource_group_location = var.resource_group_location
#     resource_group_name = var.resource_group_name
# }

# module "acr"{
#     source="./modules/acr"
#     resource_group_location = var.resource_group_location
#     resource_group_name = var.resource_group_name
# }

# module "mysql"{
#     source="./modules/db_mysql"
#     resource_group_location = var.resource_group_location
#     resource_group_name = var.resource_group_name
#     mysql_admin = var.mysql_admin
#     mysql_password = var.mysql_password
#     vnet_name = var.vnet_name
#     azure_virtual_network_id = module.vnet.vnet_id
#     depends_on=[module.vnet]
# }

# module "postgres"{
#     source="./modules/db_pg"
#     resource_group_location = var.resource_group_location
#     resource_group_name = var.resource_group_name
#     postgres_admin = var.postgres_admin
#     postgres_password = var.postgres_password
#     vnet_name = var.vnet_name
#     azure_virtual_network_id = module.vnet.vnet_id
#     depends_on=[module.vnet]
# }

module "aks_cluster"{
    source="./modules/aks_cluster"
    resource_group_location = var.resource_group_location
    resource_group_name = var.resource_group_name
    vnet_name = var.vnet_name
    azure_key_vault_id = data.azurerm_key_vault.keyvault.id
    azure_key_vault_tenant =data.azurerm_key_vault.keyvault.tenant_id
}

# module "aks_cluster_configurations"{
#     source="./modules/aks_cluster_configurations"
#     k8s_host = module.aks_cluster.k8s_host
#     k8s_client_certificate = module.aks_cluster.k8s_client_certificate
#     k8s_client_key = module.aks_cluster.k8s_client_key
#     k8s_cluster_ca_certificate = module.aks_cluster.k8s_cluster_ca_certificate
#     cluster_key_vault_client_id = module.cluster_key_vault_client_id
#     subscription_id = var.subscription_id
#     azure_key_vault_tenant_id = var.azure_key_vault_tenant_id
#     resource_group_name = var.resource_group_name
#     depends_on=[module.aks_cluster]
# }