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
      name = "win-vm"
    }
  }
}

provider "azurerm" {
  features {}
  # No credentials here – they will come from environment variables:
  # ARM_SUBSCRIPTION_ID, ARM_CLIENT_ID, ARM_CLIENT_SECRET, ARM_TENANT_ID
}

# Resource Group
resource "azurerm_resource_group" "rg" {
  name     = "win-rg"
  location = "East US"
}

# Virtual Network
resource "azurerm_virtual_network" "vnet" {
  name                = "win-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

# Subnet
resource "azurerm_subnet" "subnet" {
  name                 = "win-subnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

# Public IP
resource "azurerm_public_ip" "publicip" {
  name                = "win-publicip"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.

