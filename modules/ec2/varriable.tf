variable "ami" {
    description = "The AMI ID to use for the EC2 instance"
    type        = string 
}

variable "deployment_type" {
    description = "The type of deployment for the EC2 instance"
    type        = string
}

variable "security_group" {
    description = "The security group ID to associate with the EC2 instance"
    type        = string 
}

variable "tag" {
    description = "The tag to assign to the EC2 instance"
    type        = string
    default = "New CliqProperty"
}

variable "subnet_id" {
    description = "The ID of the subnet to associate with the EC2 instance"
    type        = string
}