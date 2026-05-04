output "custom_sg_id" {
    value = aws_security_group.custom_sg.id
}

output "vpc_id" {
    value = aws_vpc.custom_vpc.id
}

output "public_subnet_id" {
    value = aws_subnet.public_subnet.id
}

output "public_subnet_id_alt" {
    value = aws_subnet.public_subnet_alt.id
}