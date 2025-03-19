
data "aws_secretsmanager_secret" "db_password_example74" {
  name = "mysql/example74/DB_CREDENTIALS"
}

data "aws_secretsmanager_secret_version" "latest_example74" {
  secret_id = data.aws_secretsmanager_secret.db_password_example74.id
}

resource "aws_db_instance" "example74" {
  identifier       = "example74"
  engine           = "mysql"
  instance_class   = "db.t3.micro"
  allocated_storage = 20

  username         = "admin"           
  password         = jsondecode(data.aws_secretsmanager_secret_version.latest_example74.secret_string)["password"]

  tags = {
    Environment = "Dev"
    
  }
}
