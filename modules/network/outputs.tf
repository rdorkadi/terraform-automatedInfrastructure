output "public_subnet_1_frontend_id" {
    value = aws_subnet.public_subnet_1_frontend.id
}

output "public_subnet_2_frontend_id" {
    value = aws_subnet.public_subnet_2_frontend.id
}

output "public_subnet_3_frontend_id" {
    value = aws_subnet.public_subnet_3_frontend.id
}

output "private_subnet_1_backend_id" {
    value = aws_subnet.private_subnet_1_backend.id
}

output "private_subnet_2_backend_id" {
    value = aws_subnet.private_subnet_2_backend.id
}

output "private_subnet_3_backend_id" {
    value = aws_subnet.private_subnet_3_backend.id
}

output "private_subnet_1_database_id" {
    value = aws_subnet.private_subnet_1_database.id
}

output "private_subnet_2_database_id" {
    value = aws_subnet.private_subnet_2_database.id
}

output "private_subnet_3_database_id" {
    value = aws_subnet.private_subnet_3_database.id
}

output "vpc_id" {
    value = aws_vpc.vpc.id
}

output "vpc_cidr_block" {
    value = aws_vpc.vpc.cidr_block
}