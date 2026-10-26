provider "azurerm" {
  features {}
}

locals {
  tags = {
    project     = var.project_name
    environment = var.environment
    owner       = var.owner
  }
}

resource "azurerm_resource_group" "main" {
  name     = "rg-${var.project_name}-${var.environment}"
  location = var.location
  tags     = local.tags
}