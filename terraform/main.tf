module "vpc" {
  source = "./modules/vpc"

  vpc_cidr = var.vpc_cidr
  vpc_subnet = var.vpc_subnet
  vpc_route = var.vpc_route
  vpc_sg = var.vpc_sg
}