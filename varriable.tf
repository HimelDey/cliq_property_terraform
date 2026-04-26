variable "ami" {
    description = "The AMI ID to use for the EC2 instance"
    type        = string
    default = "ami-0da9ffeb885463685"
  
}

variable "deployment_type" {
    description = "deployment type"
    default = "stag"
}