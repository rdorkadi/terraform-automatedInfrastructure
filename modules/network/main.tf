# Create a VPC
resource "aws_vpc" "vpc" {
  cidr_block = var.cidr_block
}

# Create an internet gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  depends_on = [ aws_vpc.vpc ]
}

# Create a public subnet in AZ 1a
resource "aws_subnet" "public_subnet_1_frontend" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = var.public_subnet_1_frontend_cidr_block
  map_public_ip_on_launch = true
  availability_zone = var.availability_zone_1a
}

# Create a public subnet in AZ 1b
resource "aws_subnet" "public_subnet_2_frontend" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = var.public_subnet_2_frontend_cidr_block
  map_public_ip_on_launch = true
  availability_zone = var.availability_zone_1b
}

# Create a public subnet in AZ 1c
resource "aws_subnet" "public_subnet_3_frontend" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = var.public_subnet_3_frontend_cidr_block
  map_public_ip_on_launch = true
  availability_zone = var.availability_zone_1c
}

# Create a private subnet in AZ 1a
resource "aws_subnet" "private_subnet_1_backend" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = var.private_subnet_1_backend_cidr_block
  availability_zone = var.availability_zone_1a
}

# Create a private subnet in AZ 1b
resource "aws_subnet" "private_subnet_2_backend" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = var.private_subnet_2_backend_cidr_block
  availability_zone = var.availability_zone_1b
}

# Create a private subnet in AZ 1c
resource "aws_subnet" "private_subnet_3_backend" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = var.private_subnet_3_backend_cidr_block
  availability_zone = var.availability_zone_1c
}

#create a private subnet for database in AZ 1a
resource "aws_subnet" "private_subnet_1_database" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = var.private_subnet_1_database_cidr_block
  availability_zone = var.availability_zone_1a
}

# create a private subnet for database in AZ 1b
resource "aws_subnet" "private_subnet_2_database" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = var.private_subnet_2_database_cidr_block
  availability_zone = var.availability_zone_1b
}

# create a private subnet for database in AZ 1c
resource "aws_subnet" "private_subnet_3_database" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = var.private_subnet_3_database_cidr_block
  availability_zone = var.availability_zone_1c
}

# Create a route table for the public subnets
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.vpc.id
}

# Create a route to the internet gateway
resource "aws_route" "route_internet_gateway" {
  route_table_id = aws_route_table.public_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.igw.id
}

# Create a route table association for the public subnets 
resource "aws_route_table_association" "public_route_table_association_1" {
  subnet_id = aws_subnet.public_subnet_1_frontend.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "public_route_table_association_2" {
  subnet_id = aws_subnet.public_subnet_2_frontend.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "public_route_table_association_3" {
  subnet_id = aws_subnet.public_subnet_3_frontend.id
  route_table_id = aws_route_table.public_route_table.id
}

# Create a route table for the backend subnets
resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.vpc.id
}

# Create a route table association for the backend subnets
resource "aws_route_table_association" "private_route_table_association_1" {
  subnet_id = aws_subnet.private_subnet_1_backend.id
  route_table_id = aws_route_table.private_route_table.id
}

resource "aws_route_table_association" "private_route_table_association_2" {
  subnet_id = aws_subnet.private_subnet_2_backend.id
  route_table_id = aws_route_table.private_route_table.id
}

resource "aws_route_table_association" "private_route_table_association_3" {
  subnet_id = aws_subnet.private_subnet_3_backend.id
  route_table_id = aws_route_table.private_route_table.id
}

# Create a route table for the database subnets
resource "aws_route_table" "database_route_table" {
  vpc_id = aws_vpc.vpc.id
}

# Create a route table association for the database subnets
resource "aws_route_table_association" "database_route_table_association_1" {
  subnet_id = aws_subnet.private_subnet_1_database.id
  route_table_id = aws_route_table.database_route_table.id
}

resource "aws_route_table_association" "database_route_table_association_2" {
  subnet_id = aws_subnet.private_subnet_2_database.id
  route_table_id = aws_route_table.database_route_table.id
}

resource "aws_route_table_association" "database_route_table_association_3" {
  subnet_id = aws_subnet.private_subnet_3_database.id
  route_table_id = aws_route_table.database_route_table.id
}







































