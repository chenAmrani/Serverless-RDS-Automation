
resource "aws_db_instance" "exampleDB1" {
  Database_Name = "exampleDB1"
  Database Engine = "mysql"
  Environment = "Dev"
  instance_class = "db.t3.micro"
  allocated_storage = 20
}
