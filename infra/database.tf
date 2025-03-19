data "aws_secretsmanager_secret" "db_password" {
  name = var.secret_name
}

data "aws_secretsmanager_secret_version" "latest" {
  secret_id = data.aws_secretsmanager_secret.db_password.id
}


resource "aws_db_instance" "rds_instance" {
  identifier             = var.db_name
  engine                 = var.db_engine
  instance_class         = var.environment == "Dev" ? "db.t3.micro" : "db.t3.medium"
  allocated_storage      = var.environment == "Dev" ? 20 : 100
  db_name                = var.db_name
  username               = "admin"
  password = jsondecode(data.aws_secretsmanager_secret_version.latest.secret_string)["password"]
  db_subnet_group_name   = aws_db_subnet_group.rds_subnet_group[0].name
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  skip_final_snapshot    = true
}