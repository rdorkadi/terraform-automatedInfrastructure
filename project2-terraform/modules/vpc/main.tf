# VPC resources

# Create a VPC
resource "aws_vpc" "vpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true
}

# Create a public subnet in AZ 1a
resource "aws_subnet" "public_subnet_1_frontend" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone = "us-east-1a"
}

# Create a public subnet in AZ 1b
resource "aws_subnet" "public_subnet_2_frontend" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = "10.0.2.0/24"
  map_public_ip_on_launch = true
  availability_zone = "us-east-1b"
}

# Create a public subnet in AZ 1c
resource "aws_subnet" "public_subnet_3_frontend" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = "10.0.3.0/24"
  map_public_ip_on_launch = true
  availability_zone = "us-east-1c"
}

#create a private subnet in AZ 1a
resource "aws_subnet" "private_subnet_1_backend" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = "10.0.4.0/24"
  availability_zone = "us-east-1a"
}

#create a private subnet in AZ 1b
resource "aws_subnet" "private_subnet_2_backend" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = "10.0.5.0/24"
  availability_zone = "us-east-1b"
}

#create a private subnet in AZ 1b
resource "aws_subnet" "private_subnet_3_backend" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = "10.0.6.0/24"
  availability_zone = "us-east-1c"
}

#create a private subnet for database in AZ 1a
resource "aws_subnet" "private_subnet_1_database" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = "10.0.7.0/24"
  availability_zone = "us-east-1a"
}

# create a private subnet for database in AZ 1b
resource "aws_subnet" "private_subnet_2_database" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = "10.0.8.0/24"
  availability_zone = "us-east-1b"
}

# create a private subnet for database in AZ 1c
resource "aws_subnet" "private_subnet_3_database" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = "10.0.9.0/24"
  availability_zone = "us-east-1c"
}

# Create an internet gateway
resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.vpc.id
}

# Create a route table for public subnet 1
resource "aws_route_table" "frontend_1_route_table" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
  }
}

# Create a route table for public subnet 2
resource "aws_route_table" "frontend_2_route_table" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
  }
}

# Create a route table for public subnet 3
resource "aws_route_table" "frontend_3_route_table" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
  }
}

# Route table association for public subnet 1
resource "aws_route_table_association" "frontend_1_route_table_association" {
  subnet_id = aws_subnet.public_subnet_1_frontend.id
  route_table_id = aws_route_table.frontend_1_route_table.id
}

# Route table association for public subnet 2
resource "aws_route_table_association" "frontend_2_route_table_association" {
  subnet_id = aws_subnet.public_subnet_2_frontend.id
  route_table_id = aws_route_table.frontend_2_route_table.id
}

# Route table association for public subnet 3
resource "aws_route_table_association" "frontend_3_route_table_association" {
  subnet_id = aws_subnet.public_subnet_3_frontend.id
  route_table_id = aws_route_table.frontend_3_route_table.id 
}
