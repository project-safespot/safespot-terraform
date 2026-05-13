module "vpc" {
  source = "../../../modules/network/vpc"

  project     = var.project
  environment = var.environment
  vpc_cidr    = var.vpc_cidr

  public_subnet_cidrs      = var.public_subnet_cidrs
  private_app_subnet_cidrs = var.private_app_subnet_cidrs
  private_db_subnet_cidrs  = var.private_db_subnet_cidrs
  availability_zones       = var.availability_zones

  flow_log_s3_bucket_arn = var.flow_log_s3_bucket_arn
  flow_log_s3_prefix     = var.flow_log_s3_prefix

  common_tags = local.common_tags
}

module "sg" {
  source = "../../../modules/network/sg"

  project     = var.project
  environment = var.environment
  vpc_id      = module.vpc.vpc_id
  app_port    = var.app_port

  common_tags = local.common_tags
}

module "endpoint" {
  source = "../../../modules/network/endpoint"

  project     = var.project
  environment = var.environment
  vpc_id      = module.vpc.vpc_id

  private_app_subnet_ids      = module.vpc.private_app_subnet_ids
  private_app_route_table_ids = module.vpc.private_app_route_table_ids
  private_db_route_table_ids  = module.vpc.private_db_route_table_ids
  eks_node_sg_id              = module.sg.eks_node_sg_id
  lambda_sg_id                = module.sg.lambda_sg_id

  common_tags = local.common_tags
}