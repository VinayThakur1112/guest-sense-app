resource "azurerm_storage_account" "storage" {
  name                     = var.storage_account_name
  resource_group_name      = var.resource_group_name
  location                 = "Central India"
  account_tier             = "Standard"
  account_replication_type = "LRS"
  # Enable Data Lake Gen2 (Hierarchical Namespace)
  is_hns_enabled           = true
}

resource "azurerm_storage_container" "raw" {
  name                  = var.container_name
  storage_account_name  = azurerm_storage_account.storage.name
  container_access_type = "private"
}