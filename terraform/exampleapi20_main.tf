
data "aws_secretsmanager_secret" "db_password_exampleapi20" {
  name = "mysql/exampleapi20/DB_CREDENTIALS"
}

data "aws_secretsmanager_secret_version" "latest_exampleapi20" {
  secret_id = data.aws_secretsmanager_secret.db_password_exampleapi20.id
}

resource "aws_db_instance" "exampleapi20" {
  identifier       = "exampleapi20"
  engine           = "mysql"
  instance_class   = "db.t3.medium"
  allocated_storage = 100

  username         = "admin"           
  password         = jsondecode(data.aws_secretsmanager_secret_version.latest_exampleapi20.secret_string)["password"]

  tags = {
    Environment = "Prod"
    AutoDelete = "True"

  }
}
