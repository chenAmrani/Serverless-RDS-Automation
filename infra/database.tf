resource "aws_db_instance" "rds_instance" {
  identifier             = var.db_name
  engine                 = var.db_engine
  instance_class         = var.environment == "Dev" ? "db.t3.micro" : "db.t3.medium"
  allocated_storage      = var.environment == "Dev" ? 20 : 100
  db_name                = var.db_name
  username               = var.db_username
  password               = var.db_password
  db_subnet_group_name   = aws_db_subnet_group.rds_subnet_group.name
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  skip_final_snapshot    = true
}
