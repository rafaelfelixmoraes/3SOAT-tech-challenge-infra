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
