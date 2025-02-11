output "frontend_asg_sg_id" {
    value = aws_security_group.frontend_asg_sg.id
}

output "backend_asg_sg_id" {
    value = aws_security_group.backend_asg_sg.id
}

output "rds_sg_id" {
    value = aws_security_group.rds_sg.id
}

output "frontend_lb_sg_id" {
    value = aws_security_group.frontend_lb_sg.id
}

output "backend_lb_sg_id" {
    value = aws_security_group.backend_lb_sg.id
}