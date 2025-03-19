
data "aws_secretsmanager_secret" "db_password_example101" {
  name = "mysql/example101/DB_CREDENTIALS"
}

data "aws_secretsmanager_secret_version" "latest_example101" {
  secret_id = data.aws_secretsmanager_secret.db_password_example101.id
}

resource "aws_db_instance" "example101" {
  identifier       = "example101"
  engine           = "mysql"
  instance_class   = "db.t3.micro"
  allocated_storage = 20

  username         = "admin"           
  password         = jsondecode(data.aws_secretsmanager_secret_version.latest_example101.secret_string)["password"]

  tags = {
    Environment = "Dev"
    
  }
}
