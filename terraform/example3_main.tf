
resource "aws_db_instance" "example3" {
  identifier = "example3"
  engine = "mysql"
  instance_class = "db.t3.micro"
  allocated_storage = 20

  tags = {
    Environment = "Dev"
  }
  }
