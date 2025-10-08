variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Azure region to deploy resources"
  type        = string
  # default     = "Central India"
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

variable "acr_name" {
  description = "Azure Container Registry name"
  type        = string
}

variable "aks_name" {
  description = "AKS cluster name"
  type        = string
}

variable "create_aks" {
  description = "Flag to create AKS"
  type        = bool
  default     = true
}

variable "create_acr" {
  description = "Flag to create ACR"
  type        = bool
  default     = true
}