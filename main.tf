module "networking" {
  source = "./networking"
}

module "security" {
  source = "./security"

  vpc_id = module.networking.vpc_id
}