variable "db_name" {}
variable "db_engine" {}
variable "environment" {}

variable "db_username" {
  default = "admin"
}

variable "db_password" {
  default = "StrongPassword1234"
}

variable "secret_name" {
  description = "The name of the Secrets Manager entry for this database"
  type        = string
}

variable "secret_id" {
  description = "Unique identifier for the AWS Secrets Manager entry"
  type        = string
}