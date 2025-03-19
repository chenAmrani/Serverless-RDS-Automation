
data "aws_secretsmanager_secret" "db_password_example100" {
  name = "mysql/example100/DB_CREDENTIALS"
}

data "aws_secretsmanager_secret_version" "latest_example100" {
  secret_id = data.aws_secretsmanager_secret.db_password_example100.id
}

resource "aws_db_instance" "example100" {
  identifier       = "example100"
  engine           = "mysql"
  instance_class   = "db.t3.micro"
  allocated_storage = 20

  username         = "admin"           
  password         = jsondecode(data.aws_secretsmanager_secret_version.latest_example100.secret_string)["password"]

  tags = {
    Environment = "Dev"
    
  }
}
