
resource "aws_db_instance" "example4" {
  Database_Name = "example4"
  Database Engine = "mysql"
  Environment = "Dev"
  instance_class = "db.t3.micro"
  allocated_storage = 20
}
