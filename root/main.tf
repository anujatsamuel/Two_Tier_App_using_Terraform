module "vpc" {
  source          = "../modules/vpc"
  region          = var.region
  project_name    = var.project_name
  vpc_cidr        = var.vpc_cidr
  pub_sub_1a_cidr = var.pub_sub_1a_cidr
  pub_sub_2b_cidr = var.pub_sub_2b_cidr
  pri_sub_3a_cidr = var.pri_sub_3a_cidr
  pri_sub_4b_cidr = var.pri_sub_4b_cidr
  pri_sub_5a_cidr = var.pri_sub_5a_cidr
  pri_sub_6b_cidr = var.pri_sub_6b_cidr
}

module "nat_gw" {
  source      = "../modules/nat_gw"
  subnet1a_id = module.vpc.subnet1a_id
  subnet2b_id = module.vpc.subnet2b_id
  subnet3a_id = module.vpc.subnet3a_id
  subnet4b_id = module.vpc.subnet4b_id
  subnet5a_id = module.vpc.subnet5a_id
  subnet6b_id = module.vpc.subnet6b_id
  IGW_id      = module.vpc.IGW_id
  vpc_id      = module.vpc.vpc_id

}

module "sg" {
  source = "../modules/sg"
  vpc_id = module.vpc.vpc_id
}

module "alb" {
  source       = "../modules/alb"
  vpc_id       = module.vpc.vpc_id
  subnet1a_id  = module.vpc.subnet1a_id
  subnet2b_id  = module.vpc.subnet2b_id
  project_name = var.project_name
  alb_sg_id    = module.sg.alb_sg_id
}

module "key" {
  source = "../modules/key"
}

# creating Auto scaling group
module "asg" {
  source       = "../modules/asg"
  project_name = module.vpc.project_name
  key_name     = module.key.key_name
  client_sg_id = module.sg.client_sg_id
  subnet3a_id  = module.vpc.subnet3a_id
  subnet4b_id  = module.vpc.subnet4b_id
  tg_arn       = module.alb.tg_arn
}

# creating RDS instance
module "rds" {
  source      = "../modules/rds"
  db_sg_id    = module.sg.db_sg_id
  subnet5a_id = module.vpc.subnet5a_id
  subnet6b_id = module.vpc.subnet6b_id
  db_username = var.db_username
  db_password = var.db_password
}

# create cloudfront distribution 
module "cloudfront" {
  source                  = "../modules/cloudfront"
  certificate_domain_name = var.certificate_domain_name
  alb_domain_name         = module.alb.alb_dns_name  
  project_name            = module.vpc.project_name
}


# Add record in route 53 hosted zone

module "route53" {
  source                    = "../modules/route53"
  cloudfront_domain_name    = module.cloudfront.cloudfront_domain_name
  cloudfront_hosted_zone_id = module.cloudfront.cloudfront_hosted_zone_id

}