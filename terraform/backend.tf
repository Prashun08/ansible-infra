terraform {
  backend "azurerm" {
    resource_group_name  = "Default"
    storage_account_name = "prashuntfstate01"
    container_name       = "tfstate"
    key                  = "dev.tfstate"
  }
}