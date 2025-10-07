resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.aks_name
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = "${var.aks_name}-dns"

  default_node_pool {
    name       = "default"
    node_count = var.node_count
    vm_size    = var.node_size
  }

  identity {
    type = "SystemAssigned"
  }

  depends_on = [var.acr_id]
}

resource "azurerm_role_assignment" "aks_acr_pull" {
  principal_id                     = azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id
  role_definition_name             = "AcrPull"
  scope                            = var.acr_id
  skip_service_principal_aad_check = true
}