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

