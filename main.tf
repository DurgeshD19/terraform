module "networking" {
  source = "./modules/networking"
}

module "security" {
  source = "./modules/security"

  vpc_id = module.networking.vpc_id
}

module "eks" {
  source = "./modules/eks"

  cluster_name = "three-tier-eks"

  subnet_ids = [
    module.networking.private_app_subnet_a_id,
    module.networking.private_app_subnet_b_id
  ]
}

module "nat" {

  source = "./modules/nat"

  vpc_id = module.networking.vpc_id

  public_subnet_id = module.networking.public_subnet_a_id

  private_app_subnet_a_id = module.networking.private_app_subnet_a_id

  private_app_subnet_b_id = module.networking.private_app_subnet_b_id
}