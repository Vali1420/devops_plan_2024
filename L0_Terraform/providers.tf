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
    subscription_id = "ec541874-4359-475a-9d16-8dadc452eef5"
    client_id = "55e98494-949e-4efa-b897-f96dca2ec580"
    tenant_id = "8bc7d260-b007-467a-a533-77c9747849aa"
    # subscription_id = var.az_managed_identity_subscription_id
    # client_id = var.az_managed_identity_client_id
    # tenant_id = var.az_managed_identity_tenant_id
}