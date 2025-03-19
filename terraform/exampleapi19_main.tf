
data "aws_secretsmanager_secret" "db_password_exampleapi19" {
  name = "mysql/exampleapi19/DB_CREDENTIALS"
}

data "aws_secretsmanager_secret_version" "latest_exampleapi19" {
  secret_id = data.aws_secretsmanager_secret.db_password_exampleapi19.id
}

resource "aws_db_instance" "exampleapi19" {
  identifier       = "exampleapi19"
  engine           = "mysql"
  instance_class   = "db.t3.micro"
  allocated_storage = 20

  username         = "admin"           
  password         = jsondecode(data.aws_secretsmanager_secret_version.latest_exampleapi19.secret_string)["password"]

  tags = {
    Environment = "Dev"
    
  }
}
