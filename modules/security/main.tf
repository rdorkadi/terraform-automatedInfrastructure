# Create security group for internet load balancer
resource "aws_security_group" "frontend_lb_sg" {
  name        = var.name_fe_lg_sg
  description = "Allow HTTP inbound traffic and all outbound traffic"
  vpc_id      = var.vpc_id
}

resource "aws_vpc_security_group_ingress_rule" "allow_http" {
  security_group_id = aws_security_group.frontend_lb_sg.id
  cidr_ipv4         = var.vpc_cidr_block
  from_port         = var.from_port
  ip_protocol       = "tcp"
  to_port           = var.to_port
}

resource "aws_vpc_security_group_egress_rule" "allow_all" {
  security_group_id = aws_security_group.frontend_lb_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

# Create security group for frontend autoscaling group
resource "aws_security_group" "frontend_asg_sg" {
  vpc_id = var.vpc_id
}

resource "aws_vpc_security_group_ingress_rule" "allow_frontend_lb" {
  security_group_id            = aws_security_group.frontend_asg_sg.id
  referenced_security_group_id = aws_security_group.frontend_lb_sg.id
  from_port                    = var.from_port_frontend_lb
  ip_protocol                  = "tcp"
  to_port                      = var.to_port_frontend_lb
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
  vpc_id      = var.vpc_id
}

resource "aws_vpc_security_group_ingress_rule" "allow_backend_asg" {
  security_group_id            = aws_security_group.backend_lb_sg.id
  referenced_security_group_id = aws_security_group.frontend_asg_sg.id
  from_port                    = var.from_port_backend_lb
  ip_protocol                  = "tcp"
  to_port                      = var.to_port_backend_lb
}

resource "aws_vpc_security_group_egress_rule" "allow_all_internal_lb" {
  security_group_id = aws_security_group.backend_lb_sg.id
  cidr_ipv4 = "0.0.0.0/0"
  ip_protocol      = "-1"
}

# Create security group for backend autoscaling group

resource "aws_security_group" "backend_asg_sg" {
  vpc_id = var.vpc_id
}

resource "aws_vpc_security_group_ingress_rule" "allow_backend_lb" {
  security_group_id            = aws_security_group.backend_asg_sg.id
  referenced_security_group_id = aws_security_group.backend_lb_sg.id
  from_port                    = var.from_port_backend_asg
  ip_protocol                  = "tcp"
  to_port                      = var.to_port_backend_asg
}

resource "aws_vpc_security_group_egress_rule" "allow_all_asg_backend" {
  security_group_id = aws_security_group.backend_asg_sg.id
  cidr_ipv4 = "0.0.0.0/0"
  ip_protocol      = "-1"
}

# Create a security group for the RDS instance
resource "aws_security_group" "rds_sg" {
  name        = "rds_sg"
  description = "Allow inbound traffic from backend autoscaling group and all outbound traffic"
  vpc_id      = var.vpc_id
}

resource "aws_vpc_security_group_ingress_rule" "allow_backend_asg_rds" {
  security_group_id            = aws_security_group.rds_sg.id
  referenced_security_group_id = aws_security_group.frontend_asg_sg.id
  from_port                    = var.from_port_rds
  ip_protocol                  = "tcp"
  to_port                      = var.from_port_rds
}

resource "aws_vpc_security_group_egress_rule" "allow_all_rds" {
  security_group_id = aws_security_group.rds_sg.id
  cidr_ipv4 = "0.0.0.0/0"
  ip_protocol      = "-1"
}



