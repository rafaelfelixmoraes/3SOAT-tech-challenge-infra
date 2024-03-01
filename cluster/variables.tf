variable "region" {
    type = string
    default = "East US"
    description = "Main Region"
}

variable "resource_group_name" {
    type = string
    default = "tc-g8-resources"
    description = "Resource Group Name"
}

variable "cluster_name" {
    type = string
    default = "tech-challenge-k8s"
    description = "Cluster Name"
}

variable "pool_name" {
    type = string
    default = "defaultpool"
    description = "Pool Name"
}

variable "vm_size" {
    type = string
    default = "Standard_B2S"
    description = "VM Size"
}