variable "my-subnet-group-db" {
    description = "The name of the subnet group"
    type        = string
    default     = "my-subnet-group"
}

variable "rds_sg_id" {
    description = "The ID of the security group for the RDS instance"
    type        = string
}

variable "private_subnet_1_database_id" {
    description = "The ID of the private subnet 1"
    type        = string
}

variable "private_subnet_2_database_id" {
    description = "The ID of the private subnet 2"
    type        = string
}

variable "private_subnet_3_database_id" {
    description = "The ID of the private subnet 3"
    type        = string
}