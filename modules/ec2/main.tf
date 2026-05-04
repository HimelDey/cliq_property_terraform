provider "aws" {
    region = "ap-southeast-1"
}
resource "aws_instance" "web_server" {
    ami = var.ami
    instance_type = var.deployment_type == "production" ? "t3.large" : "t3.micro"
    subnet_id = var.subnet_id
    vpc_security_group_ids = [var.security_group]
    depends_on = [ var.subnet_id ]
    associate_public_ip_address = true
    lifecycle {
      create_before_destroy = true
    }
    user_data = <<-EOF
                #!/bin/bash
                echo "Hello, World!" > /var/www/html/index.html
                
                EOF
    tags = {
        Name = var.tag  
    }
}



