
resource "aws_db_instance" "example1" {
  identifier = "example1"
  engine = "mysql"
  instance_class = "db.t3.micro"
  allocated_storage = 20

  tags = {
    Environment = "Dev"
  }
  }
