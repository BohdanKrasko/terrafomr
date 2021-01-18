module "network" {
  source          = "./modules/network"
  vpc_name        = var.vpc_name
  instance_count  = var.instance_count
  igw_name        = var.igw_name
  cidr            = var.cidr
  azs             = var.azs
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets

}

module "instances" {
  source         = "./modules/ec2"
  pub_key        = var.pub_key
  pr_key         = var.pr_key
  vpc_name       = var.vpc_name
  vpc_id         = module.network.vpc_id
  instance_count = var.instance_count
  public_subnets = module.network.public_subnets
}

module "rds" {
  source     = "./modules/rds"
  subnet_ids = module.network.subnet_ids
  vpc_id     = module.network.vpc_id
}

