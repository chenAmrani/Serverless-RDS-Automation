
resource "aws_db_instance" "example7" {
  identifier = "example7"
  engine = "mysql"
  instance_class = "db.t3.micro"
  allocated_storage = 20

  tags = {
    Environment = "Dev"
  }
  }
