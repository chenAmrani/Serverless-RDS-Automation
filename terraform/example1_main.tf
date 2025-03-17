
resource "aws_db_instance" "example1" {
  Database_Name = "example1"
  Database Engine = "mysql"
  Environment = "Dev"
  instance_class = "db.t3.micro"
  allocated_storage = 20
}
