
resource "aws_db_instance" "exampleDBName" {
  identifier = "exampleDBName"
  engine = "mysql"
  instance_class = "db.t3.micro"
  allocated_storage = 20

  tags = {
    Environment = "Dev"
  }
  }
