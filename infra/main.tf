provider "aws" {
  region = "us-east-1"
}

data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "default_subnets" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

resource "aws_security_group" "rds_sg" {
  vpc_id = data.aws_vpc.default.id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# resource "aws_db_subnet_group" "rds_subnet_group" {
#   name       = "rds-subnet-group"
#   subnet_ids = data.aws_subnets.default_subnets.ids
# }

data "aws_db_subnet_group" "existing_rds_subnet_group" {
  name = "rds-subnet-group"
}

resource "aws_db_subnet_group" "rds_subnet_group" {
  count       = length(data.aws_db_subnet_group.existing_rds_subnet_group.id) == 0 ? 1 : 0
  name        = "rds-subnet-group-${var.environment}"
  description = "Managed by Terraform - ${var.environment} environment"
  subnet_ids  = ["subnet-0037f54547b27b174", "subnet-02e7d7a43a2e7962c", "subnet-030d4d86c73b30974"]
}