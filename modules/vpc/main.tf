resource "aws_vpc" "custom_vpc" {
  cidr_block = var.cidr_block
  tags = {
    Name = var.vpc_name
  }
}

resource "aws_subnet" "public_subnet" {
    vpc_id = aws_vpc.custom_vpc.id
    cidr_block = var.public_subnet_cidr
    availability_zone = var.zone_1
    tags = {
        Name = var.vpc_name
    }   
}

resource "aws_subnet" "public_subnet_alt" {
    vpc_id = aws_vpc.custom_vpc.id
    cidr_block = var.public_subnet_cidr_2
    availability_zone = var.zone_2
    tags = {
        Name = var.vpc_name
    } 
}

resource "aws_subnet" "private_subnet" {
    vpc_id = aws_vpc.custom_vpc.id
    cidr_block = var.private_subnet_cidr
    tags = {
        Name = var.vpc_name
    }   
}

resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.custom_vpc.id
}

resource "aws_route_table" "public_route_table" {
    vpc_id = aws_vpc.custom_vpc.id
    route{
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
    }
}

resource "aws_route_table" "private_route_table" {
    vpc_id = aws_vpc.custom_vpc.id
}

resource "aws_route_table_association" "public_route_table_association" {
    route_table_id = aws_route_table.public_route_table.id
    subnet_id = aws_subnet.public_subnet.id
}

resource "aws_route_table_association" "public_route_table_association_2" {
    route_table_id = aws_route_table.public_route_table.id
    subnet_id = aws_subnet.public_subnet_alt.id
}


resource "aws_route_table_association" "private_route_table_association" {
    route_table_id = aws_route_table.private_route_table.id
    subnet_id = aws_subnet.private_subnet.id
}

resource "aws_eip" "nat_eip" {
  domain = "vpc"
}

resource "aws_nat_gateway" "custom_nat_gateway" {
    allocation_id = aws_eip.nat_eip.id
    subnet_id = aws_subnet.private_subnet.id
  
}

resource "aws_security_group" "custom_sg" {
    vpc_id = aws_vpc.custom_vpc.id
    name = "${var.vpc_name}-sg"
    ingress{
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress{
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress{
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress{
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }



}

