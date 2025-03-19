
data "aws_secretsmanager_secret" "db_password_exampleapi18" {
  name = "mysql/exampleapi18/DB_CREDENTIALS"
}

data "aws_secretsmanager_secret_version" "latest_exampleapi18" {
  secret_id = data.aws_secretsmanager_secret.db_password_exampleapi18.id
}

resource "aws_db_instance" "exampleapi18" {
  identifier       = "exampleapi18"
  engine           = "mysql"
  instance_class   = "db.t3.micro"
  allocated_storage = 20

  username         = "admin"           
  password         = jsondecode(data.aws_secretsmanager_secret_version.latest_exampleapi18.secret_string)["password"]

  tags = {
    Environment = "Dev"
    
  }
}
