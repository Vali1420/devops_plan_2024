
variable "resource_group_location"{
    default="West Europe"
}

variable "resource_group_name"{
    default="AVL-Vali-Testing"
}

variable "vnet_name"{
    default="devops_plan_vnet"
}

variable "azure_virtual_network_id"{
  description = "Virtual Network Id"
  default=""
}

variable "azure_key_vault_id"{
    default=""
}

variable "azure_key_vault_tenant"{
    default=""
}

variable "cluster_key_vault_client_id"{
    default=""
}

variable "mysql_admin"{
}

variable "mysql_password"{
}

variable "postgres_admin"{
}

variable "postgres_password"{
}

variable "subscription_id"{
}

variable "azure_key_vault_tenant_id"{
}