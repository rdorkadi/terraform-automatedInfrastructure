variable "name_fe-lt" {
  description = "The name of the launch template"
  type        = string
  default = "frontend-launch-template"
}

variable "image_id" {
  description = "The AMI ID to use for the launch template"
  type        = string
  default = "ami-0c614dee691cbbf37"
}

variable "instance_type" {
  description = "The instance type to use for the launch template"
  type        = string
  default = "t2.micro"
}

variable "name_fe-asg" {
    description = "The name of the asg"
    type        = string
    default = "frontend-asg"
}

variable "min_size" {
    description = "The minimum size of the asg"
    type        = number
    default = 1
}

variable "max_size" {
    description = "The maximum size of the asg"
    type        = number
    default = 3
}

variable "desired_capacity" {
    description = "The desired capacity of the asg"
    type        = number
    default = 2
}

variable "name_be-lt" {
    description = "The name of the launch template"
    type        = string
    default = "backend-launch-template"
}

variable "name_be-asg" {
    description = "The name of the asg"
    type        = string
    default = "backend-asg"
}

variable "name_db_lt" {
    description = "The name of the launch template"
    type        = string
    default = "database-launch-template"
}

variable "name_db-asg" {
    description = "The name of the asg"
    type        = string
    default = "database-asg"
}

variable "name-fe-lb" {
    description = "The name of the load balancer"
    type        = string
    default = "frontend-lb"
}

variable "name-be-lb" {
    description = "The name of the load balancer"
    type        = string
    default = "backend-lb"
}

variable "frontend_asg_sg_id" {
  description = "The ID of the security group for the frontend autoscaling group"
  type        = string
  default     = ""
}

variable "public_subnet_1_frontend_id" {
  description = "The ID of the public subnet 1"
  type        = string
  default     = ""
}

variable "public_subnet_2_frontend_id" {
  description = "The ID of the public subnet 2"
  type        = string
  default     = ""
}

variable "public_subnet_3_frontend_id" {
  description = "The ID of the public subnet 3"
  type        = string
  default     = ""
}

variable "backend_asg_sg_id" {
  description = "The ID of the security group for the backend autoscaling group"
  type        = string
  default     = ""
}

variable "private_subnet_1_backend_id" {
  description = "The ID of the private subnet 1"
  type        = string
  default     = ""
}

variable "private_subnet_2_backend_id" {
  description = "The ID of the private subnet 2"
  type        = string
  default     = ""
}

variable "private_subnet_3_backend_id" {
  description = "The ID of the private subnet 3"
  type        = string
  default     = ""
}

variable "rds_sg_id" {
  description = "The ID of the security group for the RDS instance"
  type        = string
  default     = ""
}

variable "private_subnet_1_database_id" {
  description = "The ID of the private subnet 1"
  type        = string
  default     = ""
}

variable "private_subnet_2_database_id" {
  description = "The ID of the private subnet 2"
  type        = string
  default     = ""
}

variable "private_subnet_3_database_id" {
  description = "The ID of the private subnet 3"
  type        = string
  default     = ""
}

variable "frontend_lb_sg_id" {
  description = "The ID of the security group for the frontend load balancer"
  type        = string
  default     = ""
}

variable "backend_lb_sg_id" {
  description = "The ID of the security group for the backend load balancer"
  type        = string
  default     = ""
}

variable "my-subnet-group-db" {
    description = "The name of the subnet group"
    type        = string
    default     = "my-subnet-group"
}

variable "cidr_block" {
    description = "The CIDR block for the VPC"
    default     = "10.0.0.0/16"
}

variable "public_subnet_1_frontend_cidr_block" {
    description = "The CIDR block for the public subnet in AZ 1a"
    default     = "10.0.1.0/24"
}

variable "public_subnet_2_frontend_cidr_block" {
    description = "The CIDR block for the public subnet in AZ 1b"
    default     = "10.0.2.0/24"
}

variable "public_subnet_3_frontend_cidr_block" {
    description = "The CIDR block for the public subnet in AZ 1c"
    default     = "10.0.3.0/24"
}

variable "private_subnet_1_backend_cidr_block" {
    description = "The CIDR block for the private subnet in AZ 1a"
    default     = "10.0.4.0/24"
}

variable "private_subnet_2_backend_cidr_block" {
    description = "The CIDR block for the private subnet in AZ 1b"
    default     = "10.0.5.0/24"
}

variable "private_subnet_3_backend_cidr_block" {
    description = "The CIDR block for the private subnet in AZ 1c"
    default     = "10.0.6.0/24"
}

variable "private_subnet_1_database_cidr_block" {
    description = "The CIDR block for the private subnet in AZ 1a"
    default     = "10.0.7.0/24"
}

variable "private_subnet_2_database_cidr_block" {
    description = "The CIDR block for the private subnet in AZ 1b"
    default     = "10.0.8.0/24"
}

variable "private_subnet_3_database_cidr_block" {
    description = "The CIDR block for the private subnet in AZ 1c"
    default     = "10.0.9.0/24"
}

variable "availability_zone_1a" {
    description = "The availability zone for the public subnet in AZ 1a"
    default     = "us-east-1a"
}

variable "availability_zone_1b" {
    description = "The availability zone for the public subnet in AZ 1b"
    default     = "us-east-1b"
}

variable "availability_zone_1c" {
    description = "The availability zone for the public subnet in AZ 1c"
    default     = "us-east-1c"
}

variable "vpc_id" {
    description = "The ID of the VPC"
    type        = string
    default     = ""
}

variable "name_fe_lg_sg" {
    description = "The name of the security group for frontend autoscaling group"
    type        = string
    default     = "frontend_lb_sg"
}

variable "from_port" {
    description = "The port to allow traffic from"
    type        = number
    default     = 80
}

variable "to_port" {
    description = "The port to allow traffic to"
    type        = number
    default     = 80
}

variable "from_port_frontend_lb" {
    description = "The port to allow traffic from"
    type        = number
    default     = 0
}

variable "to_port_frontend_lb" {
    description = "The port to allow traffic to"
    type        = number
    default     = 0
}

variable "from_port_backend_lb" {
    description = "The port to allow traffic from"
    type        = number
    default     = 0
}

variable "to_port_backend_lb" {
    description = "The port to allow traffic to"   
    type        = number
    default     = 0
}

variable "from_port_backend_asg" {
    description = "The port to allow traffic from"
    type        = number
    default     = 0
}

variable "to_port_backend_asg" {
    description = "The port to allow traffic to"
    type        = number
    default     = 0
}

variable "from_port_rds" {
    description = "The port to allow traffic from"
    type        = number
    default     = 3306
}

variable "to_port_rds" {
    description = "The port to allow traffic to"
    type        = number
    default     = 3306
}

variable "vpc_cidr_block" {
    description = "The CIDR block of the VPC"
    type        = string
    default     = ""
}

