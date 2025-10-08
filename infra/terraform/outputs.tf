output "resource_group_name" {
  description = "The name of the created resource group"
  value       = azurerm_resource_group.rg.name
}

output "storage_account_name" {
  value = azurerm_storage_account.storage.name
}

output "storage_account_location" {
  value = azurerm_storage_account.storage.location
}

output "container_registry" {
  value = var.create_acr ? azurerm_container_registry.acr[0].name : null
}

output "aks_cluster" {
  value = var.create_aks ? azurerm_kubernetes_cluster.aks[0].name : null
}