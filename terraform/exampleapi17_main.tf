
data "aws_secretsmanager_secret" "db_password_exampleapi17" {
  name = "mysql/exampleapi17/DB_CREDENTIALS"
}

data "aws_secretsmanager_secret_version" "latest_exampleapi17" {
  secret_id = data.aws_secretsmanager_secret.db_password_exampleapi17.id
}

resource "aws_db_instance" "exampleapi17" {
  identifier       = "exampleapi17"
  engine           = "mysql"
  instance_class   = "db.t3.micro"
  allocated_storage = 20

  username         = "admin"           
  password         = jsondecode(data.aws_secretsmanager_secret_version.latest_exampleapi17.secret_string)["password"]

  tags = {
    Environment = "Dev"
    
  }
}
