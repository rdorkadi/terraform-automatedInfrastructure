# Create a Launch template for frontend instances
resource "aws_launch_template" "frontend_launch_template" {
  name = var.name_fe-asg
  image_id = var.image_id
  instance_type = var.instance_type
  vpc_security_group_ids = ["${aws_security_group.frontend_asg_sg.id}"]
}

# Create an autoscaling group for frontend instances
resource "aws_autoscaling_group" "frontend_asg" {
  name = var.name_fe-asg
  launch_template {
    id = aws_launch_template.frontend_launch_template.id
    version = "$Latest"
  }
  min_size = var.min_size
  max_size = var.max_size
  desired_capacity = var.desired_capacity
  vpc_zone_identifier = [
    aws_subnet.public_subnet_1_frontend.id,
    aws_subnet.public_subnet_2_frontend.id,
    aws_subnet.public_subnet_3_frontend.id
  ]
}

# Create a Launch template for backend instances
resource "aws_launch_template" "backend_launch_template" {
  name = var.name_be-lt
  image_id = var.image_id
  instance_type = var.instance_type
  vpc_security_group_ids = ["${aws_security_group.backend_asg_sg.id}"]
}

# Create an autoscaling group for backend instances
resource "aws_autoscaling_group" "backend_asg" {
  name = var.name_be-asg
  launch_template {
    id = aws_launch_template.backend_launch_template.id
    version = "$Latest"
  }
  min_size = var.min_size
  max_size = var.max_size
  desired_capacity = var.desired_capacity
  vpc_zone_identifier = [
    aws_subnet.private_subnet_1_backend.id,
    aws_subnet.private_subnet_2_backend.id,
    aws_subnet.private_subnet_3_backend.id
  ]
}

# Create a Launch template for database instances
resource "aws_launch_template" "database_launch_template" {
  name = var.name_db_lt
  image_id = var.image_id
  instance_type = var.instance_type
  vpc_security_group_ids = ["${aws_security_group.rds_sg.id}"]
}

# Create an autoscaling group for database instances
resource "aws_autoscaling_group" "database_asg" {
  name = var.name_db-asg
  launch_template {
    id = aws_launch_template.database_launch_template.id
    version = "$Latest"
  }
  min_size = var.min_size
  max_size = var.max_size
  desired_capacity = var.desired_capacity
  vpc_zone_identifier = [
    aws_subnet.private_subnet_1_database.id,
    aws_subnet.private_subnet_2_database.id,
    aws_subnet.private_subnet_3_database.id
  ]
}

# Create an Internet Load Balancer for frontend instances
resource "aws_lb" "frontend_lb" {
  name = var.name-fe-lb
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
  name = var.name-be-lb
  internal = true
  load_balancer_type = "application"
  security_groups = [aws_security_group.backend_lb_sg.id]
  subnets = [
    aws_subnet.private_subnet_1_backend.id,
    aws_subnet.private_subnet_2_backend.id,
    aws_subnet.private_subnet_3_backend.id
  ]
}

