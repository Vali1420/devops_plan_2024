terraform {
  required_version = ">=1.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }
  }
}


provider "azurerm"{
    features {}
    # use_msi = true
    # subscription_id = var.az_managed_identity_subscription_id
    # tenant_id = var.az_managed_identity_tenant_id
    # client_id = var.az_managed_identity_client_id
}