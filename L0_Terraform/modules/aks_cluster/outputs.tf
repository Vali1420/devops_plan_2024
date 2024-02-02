# output "k8s_host"{
#     value = azurerm_kubernetes_cluster.default.kube_config.0.host
# }

# output "k8s_client_certificate"{
#     value = azurerm_kubernetes_cluster.default.kube_config.0.client_certificate
# }

# output "k8s_client_key"{
#     value = azurerm_kubernetes_cluster.default.kube_config.0.client_key
# }

# output "k8s_cluster_ca_certificate"{
#     value = azurerm_kubernetes_cluster.default.kube_config.0.cluster_ca_certificate
# }

output "cluster_key_vault_client_id"{
    value = azurerm_kubernetes_cluster.default.key_vault_secrets_provider[0].secret_identity[0].client_id
}