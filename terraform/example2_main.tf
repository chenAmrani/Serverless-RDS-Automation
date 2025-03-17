
resource "aws_db_instance" "example2" {
  Database_Name = "example2"
  Database Engine = "mysql"
  Environment = "Dev"
  instance_class = "db.t3.micro"
  allocated_storage = 20
}
