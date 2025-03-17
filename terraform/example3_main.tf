
resource "aws_db_instance" "example3" {
  Database_Name = "example3"
  Database Engine = "mysql"
  Environment = "Dev"
  instance_class = "db.t3.micro"
  allocated_storage = 20
}
