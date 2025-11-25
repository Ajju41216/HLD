terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.46.0"
    }
  }
}
provider "azurerm" {
  subscription_id = "1ebca6dc-4adb-4bd0-9460-6bd7dbaf2ce4"
  features {}
}