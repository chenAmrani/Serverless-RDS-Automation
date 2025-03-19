
data "aws_secretsmanager_secret" "db_password_example73" {
  name = "mysql/example73/DB_CREDENTIALS"
}

data "aws_secretsmanager_secret_version" "latest_example73" {
  secret_id = data.aws_secretsmanager_secret.db_password_example73.id
}

resource "aws_db_instance" "example73" {
  identifier       = "example73"
  engine           = "mysql"
  instance_class   = "db.t3.micro"
  allocated_storage = 20

  username         = "admin"           
  password         = jsondecode(data.aws_secretsmanager_secret_version.latest_example73.secret_string)["password"]

  tags = {
    Environment = "Dev"
    
  }
}
