
resource "aws_db_instance" "example5" {
  identifier = "example5"
  engine = "mysql"
  instance_class = "db.t3.micro"
  allocated_storage = 20

  tags = {
    Environment = "Dev"
  }
  }
