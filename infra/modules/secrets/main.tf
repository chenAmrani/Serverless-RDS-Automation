variable "secret_name" {}

data "aws_secretsmanager_secret" "db_password" {
  name = var.secret_name
}

data "aws_secretsmanager_secret_version" "latest" {
  secret_id = data.aws_secretsmanager_secret.db_password.id
}

output "latest" {
  value = data.aws_secretsmanager_secret_version.latest
}
