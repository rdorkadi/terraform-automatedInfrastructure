# Create a VPC
resource "aws_vpc" "vpc" {
  cidr_block = "10.0.0.0/16"
}

# Create an internet gateway

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  depends_on = [ aws_vpc.vpc ]
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

#create a private subnet in AZ 1c
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

# Create a Launch template for frontend instances

resource "aws_launch_template" "frontend_launch_template" {
  name = "frontend-launch-template"
  image_id = "ami-0c614dee691cbbf37"
  instance_type = "t2.micro"
  vpc_security_group_ids = ["${aws_security_group.frontend_asg_sg.id}"]
}

# Create an autoscaling group for frontend instances

resource "aws_autoscaling_group" "frontend_asg" {
  name = "frontend-asg"
  launch_template {
    id = aws_launch_template.frontend_launch_template.id
    version = "$Latest"
  }
  min_size = 1
  max_size = 3
  desired_capacity = 2
  vpc_zone_identifier = [
    aws_subnet.public_subnet_1_frontend.id,
    aws_subnet.public_subnet_2_frontend.id,
    aws_subnet.public_subnet_3_frontend.id
  ]
}

# Create a Launch template for backend instances

resource "aws_launch_template" "backend_launch_template" {
  name = "backend-launch-template"
  image_id = "ami-0c614dee691cbbf37"
  instance_type = "t2.micro"
  vpc_security_group_ids = ["${aws_security_group.backend_asg_sg.id}"]
}

# Create an autoscaling group for backend instances

resource "aws_autoscaling_group" "backend_asg" {
  name = "backend-asg"
  launch_template {
    id = aws_launch_template.backend_launch_template.id
    version = "$Latest"
  }
  min_size = 1
  max_size = 3
  desired_capacity = 2
  vpc_zone_identifier = [
    aws_subnet.private_subnet_1_backend.id,
    aws_subnet.private_subnet_2_backend.id,
    aws_subnet.private_subnet_3_backend.id
  ]
}

# Create a Launch template for database instances

resource "aws_launch_template" "database_launch_template" {
  name = "database-launch-template"
  image_id = "ami-0c614dee691cbbf37"
  instance_type = "t2.micro"
  vpc_security_group_ids = ["${aws_security_group.rds_sg.id}"]
}

# Create an autoscaling group for database instances

resource "aws_autoscaling_group" "database_asg" {
  name = "database-asg"
  launch_template {
    id = aws_launch_template.database_launch_template.id
    version = "$Latest"
  }
  min_size = 1
  max_size = 3
  desired_capacity = 2
  vpc_zone_identifier = [
    aws_subnet.private_subnet_1_database.id,
    aws_subnet.private_subnet_2_database.id,
    aws_subnet.private_subnet_3_database.id
  ]
}

# Create an Internet Load Balancer for frontend instances

resource "aws_lb" "frontend_lb" {
  name = "frontend-lb"
  internal = false
  load_balancer_type = "application"
  security_groups = [aws_security_group.frontend_lb_sg.id]
  subnets = [
    aws_subnet.public_subnet_1_frontend.id,
    aws_subnet.public_subnet_2_frontend.id,
    aws_subnet.public_subnet_3_frontend.id
  ]
}

# Create an internal load balancer for backend instances

resource "aws_lb" "backend_lb" {
  name = "backend-lb"
  internal = true
  load_balancer_type = "application"
  security_groups = [aws_security_group.backend_lb_sg.id]
  subnets = [
    aws_subnet.private_subnet_1_backend.id,
    aws_subnet.private_subnet_2_backend.id,
    aws_subnet.private_subnet_3_backend.id
  ]
}


# Create security group for internet load balancer

resource "aws_security_group" "frontend_lb_sg" {
  name        = "public_lb_sg"
  description = "Allow HTTP inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.vpc.id
}

resource "aws_vpc_security_group_ingress_rule" "allow_http" {
  security_group_id = aws_security_group.frontend_lb_sg.id
  cidr_ipv4         = aws_vpc.vpc.cidr_block
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_egress_rule" "allow_all" {
  security_group_id = aws_security_group.frontend_lb_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

# Create security group for frontend autoscaling group

resource "aws_security_group" "frontend_asg_sg" {
  vpc_id = aws_vpc.vpc.id
}

resource "aws_vpc_security_group_ingress_rule" "allow_frontend_lb" {
  security_group_id            = aws_security_group.frontend_asg_sg.id
  referenced_security_group_id = aws_security_group.frontend_lb_sg.id
  from_port                    = 0
  ip_protocol                  = "tcp"
  to_port                      = 0
}

resource "aws_vpc_security_group_egress_rule" "allow_all_asg_frontend" {
  security_group_id = aws_security_group.frontend_asg_sg.id
  cidr_ipv4 = "0.0.0.0/0"
  ip_protocol      = "-1"
}

# Create security group for internal load balancer

resource "aws_security_group" "backend_lb_sg" {
  name        = "private_lb_sg"
  description = "Allow inbound traffic from frontend autoscaling group and all outbound traffic"
  vpc_id      = aws_vpc.vpc.id
}

resource "aws_vpc_security_group_ingress_rule" "allow_backend_asg" {
  security_group_id            = aws_security_group.backend_lb_sg.id
  referenced_security_group_id = aws_security_group.frontend_asg_sg.id
  from_port                    = 0
  ip_protocol                  = "tcp"
  to_port                      = 0
}

resource "aws_vpc_security_group_egress_rule" "allow_all_internal_lb" {
  security_group_id = aws_security_group.backend_lb_sg.id
  cidr_ipv4 = "0.0.0.0/0"
  ip_protocol      = "-1"
}

# Create security group for backend autoscaling group

resource "aws_security_group" "backend_asg_sg" {
  vpc_id = aws_vpc.vpc.id
}

resource "aws_vpc_security_group_ingress_rule" "allow_backend_lb" {
  security_group_id            = aws_security_group.backend_asg_sg.id
  referenced_security_group_id = aws_security_group.backend_lb_sg.id
  from_port                    = 0
  ip_protocol                  = "tcp"
  to_port                      = 0
}

resource "aws_vpc_security_group_egress_rule" "allow_all_asg_backend" {
  security_group_id = aws_security_group.backend_asg_sg.id
  cidr_ipv4 = "0.0.0.0/0"
  ip_protocol      = "-1"
}

# Create an RDS instance

resource "aws_db_instance" "rds" {
  allocated_storage    = 10
  db_name              = "mydb"
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t3.micro"
  username             = "foo"
  password             = "foobarbaz"
  skip_final_snapshot  = true
  publicly_accessible  = false
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  db_subnet_group_name = aws_db_subnet_group.subnet_group.name
}

resource "aws_db_subnet_group" "subnet_group" {
  name       = "my-subnet-group"
  subnet_ids = [
    aws_subnet.private_subnet_1_database.id,
    aws_subnet.private_subnet_2_database.id,
    aws_subnet.private_subnet_3_database.id
  ]  
}

# Create a security group for the RDS instance

resource "aws_security_group" "rds_sg" {
  name        = "rds_sg"
  description = "Allow inbound traffic from backend autoscaling group and all outbound traffic"
  vpc_id      = aws_vpc.vpc.id
}

resource "aws_vpc_security_group_ingress_rule" "allow_backend_asg_rds" {
  security_group_id            = aws_security_group.rds_sg.id
  referenced_security_group_id = aws_security_group.frontend_asg_sg.id
  from_port                    = 3306
  ip_protocol                  = "tcp"
  to_port                      = 3306
}

resource "aws_vpc_security_group_egress_rule" "allow_all_rds" {
  security_group_id = aws_security_group.rds_sg.id
  cidr_ipv4 = "0.0.0.0/0"
  ip_protocol      = "-1"
}