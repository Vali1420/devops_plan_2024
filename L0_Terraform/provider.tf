terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.70.0"
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

# -var az_managed_identity_subscription_id=${{ secrets.AZURE_SUBSCRIPTION_ID }}
# -var az_managed_identity_tenant_id=${{ secrets.AZURE_TENANT_ID }}
# -var az_managed_identity_client_id=${{ secrets.AZURE_CLIENT_ID }}