variable "db_name" {
  description = "Database name for the RDS instance"
  type        = string
}

variable "db_engine" {
  description = "Database engine type (e.g., MySQL, PostgreSQL)"
  type        = string
}

variable "environment" {
  description = "Environment type (e.g., Dev, Prod)"
  type        = string
}

variable "secret_name" {
  description = "The name of the Secrets Manager entry for this database"
  type        = string
}

variable "secret_id" {
  description = "Unique identifier for the AWS Secrets Manager entry"
  type        = string
}

variable "db_username" {
  description = "Username for the database"
  default     = "admin"
}

variable "db_password" {
  description = "Password for the database"
  default     = "StrongPassword1234"
}
