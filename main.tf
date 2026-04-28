module "custom_vpc" {
    source = "./modules/vpc"
    cidr_block = "10.0.0.0/16"
    vpc_name = "custom-vpc"
    public_subnet_cidr = "10.0.1.0/24"
    private_subnet_cidr = "10.0.2.0/24"
}

module "ec2" {
    source = "./modules/ec2"
    ami = var.ami
    deployment_type = var.deployment_type
    security_group = module.custom_vpc.custom_sg_id
    
}

