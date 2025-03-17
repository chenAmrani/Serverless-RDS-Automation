
resource "aws_db_instance" "exampleDB4" {
  Database_Name = "exampleDB4"
  Database Engine = "mysql"
  Environment = "Dev"
  instance_class = "db.t3.micro"
  allocated_storage = 20
}
