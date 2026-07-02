# DB Subnet Group
resource "aws_db_subnet_group" "main" {
  name       = "${var.project_name}-db-subnet-group"
  subnet_ids = [var.private_db_subnet_1_id, var.private_db_subnet_2_id]

  tags = {
    Name = "${var.project_name}-db-subnet-group"
  }
}

# RDS MySQL Multi-AZ Instance
resource "aws_db_instance" "main" {
  identifier             = "${var.project_name}-rds"
  engine                 = "mysql"
  engine_version         = "8.0"
  instance_class         = "db.t3.micro"
  allocated_storage      = 20
  storage_type           = "gp2"
  db_name                = "appdb"
  username               = var.db_username
  password               = var.db_password
  db_subnet_group_name   = aws_db_subnet_group.main.name
  vpc_security_group_ids = [var.db_sg_id]
  multi_az               = true
  skip_final_snapshot    = true
  publicly_accessible    = false

  tags = {
    Name = "${var.project_name}-rds"
  }
}
