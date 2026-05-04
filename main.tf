provider "aws" {
    region = "ap-southeast-1"
}
module "custom_vpc" {
    source = "./modules/vpc"
    cidr_block = "10.0.0.0/16"
    vpc_name = "custom-vpc"
    public_subnet_cidr = "10.0.1.0/24"
    private_subnet_cidr = "10.0.2.0/24"
    public_subnet_cidr_2 = "10.0.3.0/24"
    zone_1 = "ap-southeast-1a"
    zone_2 = "ap-southeast-1b"
}

module "ec2" {
    source = "./modules/ec2"
    ami = var.ami
    deployment_type = var.deployment_type
    security_group = module.custom_vpc.custom_sg_id
    subnet_id = module.custom_vpc.public_subnet_id
}

module "alb" {
    source = "./modules/alb"
    certificate_arn = var.certificate_arn
    vpc_id = module.custom_vpc.vpc_id  
    instance_id = module.ec2.instance_id
    public_subnet_id = module.custom_vpc.public_subnet_id
    public_subnet_id_alt = module.custom_vpc.public_subnet_id_alt
    security_group_id = module.custom_vpc.custom_sg_id
}

