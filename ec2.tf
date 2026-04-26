module "ec2" {
    source = "./modules/ec2"
    ami = var.ami
    deployment_type = var.deployment_type
}