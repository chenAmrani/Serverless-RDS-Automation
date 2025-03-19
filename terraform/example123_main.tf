
data "aws_secretsmanager_secret" "db_password_example123" {
  name = "mysql/example123/DB_CREDENTIALS"
}

data "aws_secretsmanager_secret_version" "latest_example123" {
  secret_id = data.aws_secretsmanager_secret.db_password_example123.id
}

resource "aws_db_instance" "example123" {
  identifier       = "example123"
  engine           = "mysql"
  instance_class   = "db.t3.micro"
  allocated_storage = 20

  username         = "admin"           
  password         = jsondecode(data.aws_secretsmanager_secret_version.latest_example123.secret_string)["password"]

  tags = {
    Environment = "Dev"
    
  }
}
