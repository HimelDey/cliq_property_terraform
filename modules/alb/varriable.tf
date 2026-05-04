variable "certificate_arn" {
    description = "The ARN of the SSL certificate for HTTPS listener"
    type        = string
}

variable "vpc_id" {
    description = "The ID of the VPC to associate with the EC2 instance"
    type        = string
}

variable "instance_id" {
    description = "The ID of the EC2 instance to associate with the target group"
    type        = string
}

variable "public_subnet_id" {
    description = "The ID of the public subnet to associate with the ALB"
    type        = string
}

variable "public_subnet_id_alt" {
    description = "The ID of the public subnet to associate with the ALB"
    type        = string
}


variable "security_group_id" {
    description = "The ID of the security group to associate with the ALB"
    type        = string
}