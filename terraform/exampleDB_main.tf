
resource "aws_db_instance" "exampleDB" {
  Database_Name = "exampleDB"
  Database Engine = "mysql"
  Environment = "Dev"
  instance_class = "db.t3.micro"
  allocated_storage = 20
}
