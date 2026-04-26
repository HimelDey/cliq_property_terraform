provider "aws" {
    region = "ap-southeast-1"
}

resource "aws_instance" "web_server" {
    ami = var.ami
    instance_type = var.deployment_type == "production" ? "t3.large" : "t3.micro"
    security_groups = [aws_security_group.web_sg.name]
    lifecycle {
      create_before_destroy = true
    }
}



