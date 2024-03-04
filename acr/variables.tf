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

variable "acr_name" {
    type = string
    default = "acrrepository"
    description = "ACR Name"
}

variable "sku_type" {
    type = string
    default = "Basic"
    description = "Sku Type"
}