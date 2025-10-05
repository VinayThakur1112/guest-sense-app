variable "resource_group_name" {
  description = "The name of the resource group to create"
  type        = string
  default     = "demo-rg"
}

variable "location" {
  description = "Azure region where the resource group will be created"
  type        = string
  default     = "East US"
}