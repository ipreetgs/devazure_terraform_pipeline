
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "2.98.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "my_rg" {
  name     = var.my_rg
  location = "central india"
}

module "backend" {
  source = "./modules/backend"
  target = modules.azurerm_virtual_network.my_asg
  my_rg =var.my_rg
  rg_name = azurerm_resource_group.my_rg.name
  my_loc  = azurerm_resource_group.my_rg.location


module "frontend" {
  source  = "./modules/frontend"
  my_rg   = var.my_rg
  rg_name = azurerm_resource_group.my_rg.name
  my_loc  = azurerm_resource_group.my_rg.location
} 
}