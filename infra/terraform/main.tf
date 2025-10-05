terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.100.0"
    }
  }

  required_version = ">= 1.5.0"
}

provider "azurerm" {
  features {}
}

# Create Resource Group
module "resource_group" {
  source              = "./modules/resource_group"
  resource_group_name = var.resource_group_name
  location            = var.location
}

# Create Storage Account
module "storage_account" {
  source               = "./modules/storage_accounts"
  resource_group_name  = module.resource_group.name
  location             = module.resource_group.location
  storage_account_name = var.storage_account_name
  container_name       = var.container_name
}