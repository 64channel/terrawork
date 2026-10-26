terraform {
  backend "azurerm" {
    resource_group_name  = "rg-fleet-health-tfstate"
    storage_account_name = "tfstatebkbr"
    container_name       = "tfstatebkbrcontainer"
    key                  = "fleet-health.tfstate"
    use_azuread_auth     = true
  }
}