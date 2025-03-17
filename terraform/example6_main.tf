
resource "aws_db_instance" "example6" {
  Database_Name = "example6"
  Database Engine = "mysql"
  Environment = "Dev"
  instance_class = "db.t3.micro"
  allocated_storage = 20
}
