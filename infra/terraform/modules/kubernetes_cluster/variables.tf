variable "aks_name" {
  description = "AKS name"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group name"
  type        = string
}

variable "location" {
  description = "Azure location"
  type        = string
}

variable "acr_id" {
  description = "ACR ID to assign AcrPull role"
  type        = string
}

variable "node_count" {
  description = "Number of AKS nodes"
  type        = number
  default     = 1
}

variable "node_size" {
  description = "VM size for nodes"
  type        = string
  default     = "Standard_B2s"
}