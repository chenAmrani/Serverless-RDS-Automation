
resource "aws_db_instance" "example9" {
  identifier = "example9"
  engine = "mysql"
  instance_class = "db.t3.micro"
  allocated_storage = 20

  tags = {
    Environment = "Dev"
  }
  }
