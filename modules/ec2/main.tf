provider "aws" {
    region = "ap-southeast-1"
}

resource "aws_instance" "web_server" {
    ami = var.ami
    instance_type = var.deployment_type == "production" ? "t3.large" : "t3.micro"
    vpc_security_group_ids = [var.security_group]
    lifecycle {
      create_before_destroy = true
    }
}



