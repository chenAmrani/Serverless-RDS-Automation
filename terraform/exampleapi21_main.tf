
data "aws_secretsmanager_secret" "db_password_exampleapi21" {
  name = "mysql/exampleapi21/DB_CREDENTIALS"
}

data "aws_secretsmanager_secret_version" "latest_exampleapi21" {
  secret_id = data.aws_secretsmanager_secret.db_password_exampleapi21.id
}

resource "aws_db_instance" "exampleapi21" {
  identifier       = "exampleapi21"
  engine           = "mysql"
  instance_class   = "db.t3.medium"
  allocated_storage = 100

  username         = "admin"           
  password         = jsondecode(data.aws_secretsmanager_secret_version.latest_exampleapi21.secret_string)["password"]

  tags = {
    Environment = "Prod"
    AutoDelete = "True"

  }
}
