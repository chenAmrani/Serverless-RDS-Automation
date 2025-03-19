
data "aws_secretsmanager_secret" "db_password_exampleApi15" {
  name = "mysql/exampleApi15/DB_CREDENTIALS"
}

data "aws_secretsmanager_secret_version" "latest_exampleApi15" {
  secret_id = data.aws_secretsmanager_secret.db_password_exampleApi15.id
}

resource "aws_db_instance" "exampleApi15" {
  identifier       = "exampleApi15"
  engine           = "mysql"
  instance_class   = "db.t3.micro"
  allocated_storage = 20

  username         = "admin"           
  password         = jsondecode(data.aws_secretsmanager_secret_version.latest_exampleApi15.secret_string)["password"]

  tags = {
    Environment = "Dev"
    
  }
}
