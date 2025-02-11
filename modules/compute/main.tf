# Create a Launch template for frontend instances
resource "aws_launch_template" "frontend_launch_template" {
  name = var.name_fe-asg
  image_id = var.image_id
  instance_type = var.instance_type
  vpc_security_group_ids = ["${var.frontend_asg_sg_id}"]
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
    var.public_subnet_1_frontend_id,
    var.public_subnet_2_frontend_id,
    var.public_subnet_3_frontend_id
  ]
}

# Create a Launch template for backend instances
resource "aws_launch_template" "backend_launch_template" {
  name = var.name_be-lt
  image_id = var.image_id
  instance_type = var.instance_type
  vpc_security_group_ids = ["${var.backend_asg_sg_id}"]
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
    var.private_subnet_1_backend_id,
    var.private_subnet_2_backend_id,
    var.private_subnet_3_backend_id
  ]
}

# Create a Launch template for database instances
resource "aws_launch_template" "database_launch_template" {
  name = var.name_db_lt
  image_id = var.image_id
  instance_type = var.instance_type
  vpc_security_group_ids = ["${var.rds_sg_id}"]
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
    var.private_subnet_1_database_id,
    var.private_subnet_2_database_id,
    var.private_subnet_3_database_id
  ]
}

# Create an Internet Load Balancer for frontend instances
resource "aws_lb" "frontend_lb" {
  name = var.name-fe-lb
  internal = false
  load_balancer_type = "application"
  security_groups = [var.frontend_lb_sg_id]
  subnets = [
    var.public_subnet_1_frontend_id,
    var.public_subnet_2_frontend_id,
    var.public_subnet_3_frontend_id
  ]
}

# Create an internal load balancer for backend instances

resource "aws_lb" "backend_lb" {
  name = var.name-be-lb
  internal = true
  load_balancer_type = "application"
  security_groups = [var.backend_lb_sg_id]
  subnets = [
    var.private_subnet_1_backend_id,
    var.private_subnet_2_backend_id,
    var.private_subnet_3_backend_id
  ]
}

