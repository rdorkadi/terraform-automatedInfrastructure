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

