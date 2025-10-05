module "vpc" {
  source = "./modules/vpc"
  project_name          = var.project_name
  vpc_cidr              = var.vpc_cidr
  public_subnet_1_cidr  = var.public_subnet_1_cidr
  public_subnet_2_cidr  = var.public_subnet_2_cidr
  public_subnet_1_az    = var.public_subnet_1_az
  public_subnet_2_az    = var.public_subnet_2_az
}

module "Iam" {
  source = "./modules/Iam"
}

module "route53_dns" {
  source       = "./modules/route53_dns"
  domain_name  = var.domain_name
  record_name  = var.record_name   
  alb_dns_name = module.alb.alb_dns_name
  alb_zone_id  = module.alb.alb_zone_id
}

module "acm" {
  source      = "./modules/acm"
  domain_name = var.domain_name
}
module "security_groups" {
  source = "./modules/security_groups"
  vpc_id = module.vpc.vpc_id
}

module "alb" {
  source                 = "./modules/alb"
  project_name           = var.project_name
  vpc_id                 = module.vpc.vpc_id
  subnet1_id             = module.vpc.subnet1_id
  subnet2_id             = module.vpc.subnet2_id
  security_group_alb_ids = module.security_groups.security_group_alb_ids
  certificate_arn        = module.acm.certificate_arn
}

module "ecs_service" {
  source = "./modules/ecs_service"
  project_name                                = module.vpc.project_name
  subnet1_id                                  = module.vpc.subnet1_id
  subnet2_id                                  = module.vpc.subnet2_id
  security_group_ecs_ids                      = module.security_groups.security_group_ecs_ids
  ecs_task_execution_role                     = module.Iam.ecs_task_execution_role
  target_group_arn                            = module.alb.target_group_arn
  ecr_image_url                               = var.ecr_image_url
  task_cpu                                    = var.task_cpu
  task_memory                                 = var.task_memory
  containerPort                               = var.containerPort
  ecs_task_deployment_minimum_healthy_percent = var.ecs_task_deployment_minimum_healthy_percent
  ecs_task_deployment_maximum_percent         = var.ecs_task_deployment_maximum_percent
  alb_https_listener_arn                      = module.alb.alb_https_listener_arn
}