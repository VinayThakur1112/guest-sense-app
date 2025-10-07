variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Azure region to deploy resources"
  type        = string
  default     = "Central India"
}

variable "storage_account_name" {
  description = "Name of the storage account (must be globally unique)"
  type        = string
}

variable "container_name" {
  description = "Name of the storage container"
  type        = string
  default     = "raw-data"
}

variable "create_container_registry" {
  description = "Whether to create Azure Container Registry"
  type        = bool
  default     = false
}

variable "create_kubernetes_cluster" {
  description = "Whether to create Azure Kubernetes Cluster"
  type        = bool
  default     = false
}