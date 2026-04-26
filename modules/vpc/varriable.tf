variable "cidr_block" {
    description = "The CIDR block for the VPC."
    type        = string
}

variable "vpc_name" {
    description = "The name for the VPC."
    type        = string
}

variable "public_subnet_cidr" {
    description = "The CIDR block for the public subnet."
    type        = string
}

variable "private_subnet_cidr" {
    description = "The CIDR block for the public subnet."
    type        = string
}