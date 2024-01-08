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
}