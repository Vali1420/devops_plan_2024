
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

variable "mysql_admin"{
}

variable "mysql_password"{
}