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