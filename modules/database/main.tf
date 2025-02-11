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
  vpc_security_group_ids = [var.rds_sg_id]
  db_subnet_group_name = aws_db_subnet_group.subnet_group.name
}

resource "aws_db_subnet_group" "subnet_group" {
  name       = var.my-subnet-group-db
  subnet_ids = [
    var.private_subnet_1_database_id,
    var.private_subnet_2_database_id,
    var.private_subnet_3_database_id
  ]
}