module "compute" {
  source = "./modules/compute"
  name_fe-lt = var.name_fe-lt
  image_id = var.image_id
  instance_type = var.instance_type
  name_fe-asg = var.name_fe-asg
  min_size = var.min_size
  max_size = var.max_size
  desired_capacity = var.desired_capacity
  name_be-lt = var.name_be-lt
  name_be-asg = var.name_be-asg
  name_db_lt = var.name_db_lt
  name_db-asg = var.name_db-asg
  name-fe-lb  = var.name-fe-lb
  name-be-lb = var.name-be-lb
  frontend_asg_sg_id = module.security.frontend_asg_sg_id
  public_subnet_1_frontend_id = module.network.public_subnet_1_frontend_id
  public_subnet_2_frontend_id = module.network.public_subnet_2_frontend_id
  public_subnet_3_frontend_id = module.network.public_subnet_3_frontend_id
  backend_asg_sg_id = module.security.backend_asg_sg_id
  private_subnet_1_backend_id = module.network.private_subnet_1_backend_id
  private_subnet_2_backend_id = module.network.private_subnet_2_backend_id
  private_subnet_3_backend_id = module.network.private_subnet_3_backend_id  
  rds_sg_id = module.security.rds_sg_id
  private_subnet_1_database_id = module.network.private_subnet_1_database_id
  private_subnet_2_database_id = module.network.private_subnet_2_database_id
  private_subnet_3_database_id = module.network.private_subnet_3_database_id
  frontend_lb_sg_id = module.security.frontend_lb_sg_id
  backend_lb_sg_id = module.security.backend_lb_sg_id
}

module "database" {
  source = "./modules/database"
  my-subnet-group-db = var.my-subnet-group-db
  rds_sg_id = module.security.rds_sg_id
  private_subnet_1_database_id = module.network.private_subnet_1_database_id
  private_subnet_2_database_id = module.network.private_subnet_2_database_id
  private_subnet_3_database_id = module.network.private_subnet_3_database_id
}

module "network" {
  source = "./modules/network"
  cidr_block = var.cidr_block
  public_subnet_1_frontend_cidr_block = var.public_subnet_1_frontend_cidr_block
  public_subnet_2_frontend_cidr_block = var.public_subnet_2_frontend_cidr_block
  public_subnet_3_frontend_cidr_block = var.public_subnet_3_frontend_cidr_block
  private_subnet_1_backend_cidr_block = var.private_subnet_1_backend_cidr_block
  private_subnet_2_backend_cidr_block = var.private_subnet_2_backend_cidr_block
  private_subnet_3_backend_cidr_block = var.private_subnet_3_backend_cidr_block
  private_subnet_1_database_cidr_block = var.private_subnet_1_database_cidr_block
  private_subnet_2_database_cidr_block = var.private_subnet_2_database_cidr_block
  private_subnet_3_database_cidr_block = var.private_subnet_3_database_cidr_block
  availability_zone_1a = var.availability_zone_1a
  availability_zone_1b = var.availability_zone_1b
  availability_zone_1c = var.availability_zone_1c
}

module "security" {
  source = "./modules/security"
  name_fe_lg_sg = var.name_fe_lg_sg
  from_port = var.from_port
  to_port = var.to_port
  from_port_frontend_lb = var.from_port_frontend_lb
  to_port_frontend_lb = var.to_port_frontend_lb
  from_port_backend_lb = var.from_port_backend_lb
  to_port_backend_lb = var.to_port_backend_lb
  from_port_backend_asg = var.from_port_backend_asg
  to_port_backend_asg = var.to_port_backend_asg
  from_port_rds = var.from_port_rds
  to_port_rds = var.to_port_rds
  vpc_id = module.network.vpc_id
  vpc_cidr_block = module.network.vpc_cidr_block
}

