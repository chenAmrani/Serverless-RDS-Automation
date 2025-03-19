
data "aws_secretsmanager_secret" "db_password_example202" {
  name = "mysql/example202/DB_CREDENTIALS"
}

data "aws_secretsmanager_secret_version" "latest_example202" {
  secret_id = data.aws_secretsmanager_secret.db_password_example202.id
}

resource "aws_db_instance" "example202" {
  identifier       = "example202"
  engine           = "mysql"
  instance_class   = "db.t3.micro"
  allocated_storage = 20

  username         = "admin"           
  password         = jsondecode(data.aws_secretsmanager_secret_version.latest_example202.secret_string)["password"]

  tags = {
    Environment = "Dev"
    
  }
}
