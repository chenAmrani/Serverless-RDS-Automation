
resource "aws_db_instance" "example5" {
  Database_Name = "example5"
  Database Engine = "mysql"
  Environment = "Dev"
  instance_class = "db.t3.micro"
  allocated_storage = 20
}
