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