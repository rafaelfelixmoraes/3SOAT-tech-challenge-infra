variable "region" {
    type = string
    default = "East US"
    description = "Main Region"
}

variable "tags" {
    type = map
    default = {
        Name = "Function to 3SOAT Tech Challenge"
        Environment = "Development"
    }
}

variable "resource_group_name" {
    type = string
    default = "tc-g8-resources"
    description = "Default Resource group"
}
