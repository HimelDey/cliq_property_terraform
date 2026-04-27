provider "aws" {
    region = "ap-southeast-1"
}

resource "aws_security_group" "web_sg" {
  name        = "web-server-sg"
  description = "Security group for EC2 web server"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "web-server-sg"
  }
}

resource "aws_instance" "web_server" {
    ami = var.ami
    instance_type = var.deployment_type == "production" ? "t3.large" : "t3.micro"
    vpc_security_group_ids = [aws_security_group.web_sg.id]
    lifecycle {
      create_before_destroy = true
    }
}



