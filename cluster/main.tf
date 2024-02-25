terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.93.0"
    }
  }
}

provider "azurerm" {
  # Configuration options
  features {
    
  }
}

resource "azurerm_resource_group" "tech-challenge" {
  name     = var.resource_group_name
  location = var.region
}

resource "azurerm_kubernetes_cluster" "tech-challenge-k8s" {
  name                = var.cluster_name
  location            = azurerm_resource_group.tech-challenge.location
  resource_group_name = azurerm_resource_group.tech-challenge.name
  dns_prefix          = var.cluster_name

  default_node_pool {
    name       = var.pool_name
    node_count = 1
    vm_size    = var.vm_size
  }

  //service_principal {
  //  client_id     = "0000000"
  //  client_secret = "00000000"
  //}
}

resource "azurerm_kubernetes_cluster_node_pool" "cluster-node-pool" {
  name                  = "internal"
  kubernetes_cluster_id = azurerm_kubernetes_cluster.tech-challenge-k8s.id
  vm_size               = var.vm_size
  node_count            = 1
}