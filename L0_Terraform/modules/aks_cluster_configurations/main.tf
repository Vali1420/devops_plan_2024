terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.0.0"
      configuration_aliases = [ kubernetes.cluster ]
    }
  }
}

# provider "kubernetes" {
#   host = var.k8s_host

#   client_certificate     = base64decode(var.k8s_client_certificate)
#   client_key             = base64decode(var.k8s_client_key)
#   cluster_ca_certificate = base64decode(var.k8s_cluster_ca_certificate)
# }

resource "kubernetes_manifest" "secretproviderclass" {
  provider = kubernetes.cluster

  manifest = {
    "apiVersion" = "secrets-store.csi.x-k8s.io/v1alpha1"
    "kind"       = "SecretProviderClass"
    "metadata" = {
      "name"      = "azure-rkimkv-secret-provider"
      "namespace" = "default"
    }
    "spec" = {
      "provider" = "azure"
      "parameters" = {
        "resourceGroup"  = "${var.resource_group_name}"
        "subscriptionId" = "${var.subscription_id}"
        "tenantId"       = "${var.azure_key_vault_tenant_id}"
        "usePodIdentity" = "false"
        "useVMManagedIdentity" = "true"
        "userAssignedIdentityID" = "${var.cluster_key_vault_client_id}"
        "keyvaultName"   = "KeyVaultCarWeb"
        "objects" = jsonencode([{
          "objectName" = "CarWebAppConnectionString"
          "objectType" = "secret"
        }])
      }
      "secretObjects" = jsonencode([{
        "secretName"     = "CarWebAppConnectionString"
        "secretTemplate" = {
          "data" = {
            "password" = "@Microsoft.KeyVault(CarWebAppConnectionString)"
          }
        }
      }])
    }
  }
}