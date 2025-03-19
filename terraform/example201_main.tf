
data "aws_secretsmanager_secret" "db_password_example201" {
  name = "mysql/example201/DB_CREDENTIALS"
}

data "aws_secretsmanager_secret_version" "latest_example201" {
  secret_id = data.aws_secretsmanager_secret.db_password_example201.id
}

resource "aws_db_instance" "example201" {
  identifier       = "example201"
  engine           = "mysql"
  instance_class   = "db.t3.micro"
  allocated_storage = 20

  username         = "admin"           
  password         = jsondecode(data.aws_secretsmanager_secret_version.latest_example201.secret_string)["password"]

  tags = {
    Environment = "Dev"
    
  }
}
