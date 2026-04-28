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