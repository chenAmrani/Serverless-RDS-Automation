
data "aws_secretsmanager_secret" "db_password" {
  name = "mysql/example34/DB_CREDENTIALS"
}

data "aws_secretsmanager_secret_version" "latest" {
  secret_id = data.aws_secretsmanager_secret.db_password.id
}

resource "aws_db_instance" "example34" {
  identifier       = "example34"
  engine           = "mysql"
  instance_class   = "db.t3.micro"
  allocated_storage = 20

  username         = "admin"           
  password         = jsondecode(data.aws_secretsmanager_secret_version.latest.secret_string)["password"]

  tags = {
    Environment = "Dev"
    
  }
}
