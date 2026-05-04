variable "ami" {
    description = "The AMI ID to use for the EC2 instance"
    type        = string
    default = "ami-0a84a03957476a2cc"
  
}

variable "deployment_type" {
    description = "deployment type"
    default = "stag"
}

variable "certificate_arn" {
    description = "The ARN of the SSL certificate for HTTPS listener"
    type        = string
    default = "arn:aws:acm:ap-southeast-1:170077071405:certificate/54376689-6318-43ef-ac7d-06c94b08d68a"
  
}