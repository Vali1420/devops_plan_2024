terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.70.0"
    }
  }
}


provider "azurerm"{
    # skip_provider_registration = "true"
    features {}
    use_msi = true
    subscription_id = var.az_managed_identity_subscription_id
    client_id = var.az_managed_identity_client_id
    tenant_id = var.az_managed_identity_tenant_id
}

