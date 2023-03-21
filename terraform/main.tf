provider "azurerm" {
  features {}
}

terraform {
  backend "azurerm" {
    storage_account_name = "azfkterraformbackend"
    container_name       = "azfkterraformbackend"
    key                  = "terraform.tfstate"
  }
}


resource "azurerm_storage_account" "storage_account" {
  name                     = "azfkstorageaccount"
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_service_plan" "service_plan" {
  name                = "app-service-plan"
  location            = var.location
  resource_group_name = var.resource_group_name
  os_type             = "Linux"
  sku_name            = "Y1"
}

resource "azurerm_linux_function_app" "azure_function" {
  name                = "azfk-azure-function"
  location            = var.location
  resource_group_name = var.resource_group_name

  service_plan_id            = azurerm_service_plan.service_plan.id
  storage_account_name       = azurerm_storage_account.storage_account.name
  storage_account_access_key = azurerm_storage_account.storage_account.primary_access_key

  site_config {
    application_stack {
      python_version = 3.8
    }
  }
}
