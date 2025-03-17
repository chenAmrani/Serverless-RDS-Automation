
resource "aws_db_instance" "example7" {
  Database_Name = "example7"
  Database Engine = "mysql"
  Environment = "Dev"
  instance_class = "db.t3.micro"
  allocated_storage = 20
}
