
data "aws_secretsmanager_secret" "db_password_example200" {
  name = "mysql/example200/DB_CREDENTIALS"
}

data "aws_secretsmanager_secret_version" "latest_example200" {
  secret_id = data.aws_secretsmanager_secret.db_password_example200.id
}

resource "aws_db_instance" "example200" {
  identifier       = "example200"
  engine           = "mysql"
  instance_class   = "db.t3.micro"
  allocated_storage = 20

  username         = "admin"           
  password         = jsondecode(data.aws_secretsmanager_secret_version.latest_example200.secret_string)["password"]

  tags = {
    Environment = "Dev"
    
  }
}
