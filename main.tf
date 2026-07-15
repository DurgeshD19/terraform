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
    module.networking.private_app_subnet_a,
    module.networking.private_app_subnet_b
  ]
}