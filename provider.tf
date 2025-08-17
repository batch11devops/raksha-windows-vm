terraform {
  required_version = ">= 1.6"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }

  cloud {
    organization = "raksha-terra-org"
    workspaces {
      name = "raksha-windows-vm"
    }
  }
}

provider "azurerm" {
  features {}
}

