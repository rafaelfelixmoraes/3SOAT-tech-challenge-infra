resource "azurerm_kubernetes_cluster" "tech-challenge-k8s" {
  name                = var.cluster_name
  location            = var.region
  resource_group_name = var.resource_group_name
  dns_prefix          = var.cluster_name

  default_node_pool {
    name       = var.pool_name
    node_count = 1
    vm_size    = var.vm_size
  }

  service_principal {
    client_id     = "e0e46b94-74f2-4134-a6eb-7dcf00a5f1d4"
    client_secret = "O288Q~pkw1TiJdHyJ_.orZNDkJ3qWqN9EAj5~bWZ"
  }
}

resource "azurerm_kubernetes_cluster_node_pool" "cluster-node-pool" {
  name                  = "internal"
  kubernetes_cluster_id = azurerm_kubernetes_cluster.tech-challenge-k8s.id
  vm_size               = var.vm_size
  node_count            = 1
}