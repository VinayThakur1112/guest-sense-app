output "aks_name" {
  value = azurerm_kubernetes_cluster.aks.name
}

output "kubeconfig" {
  value     = azurerm_kubernetes_cluster.aks.kube_config_raw
  sensitive = true
}