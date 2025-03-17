
resource "aws_db_instance" "exampleDB3" {
  Database_Name = "exampleDB3"
  Database Engine = "mysql"
  Environment = "Dev"
  instance_class = "db.t3.micro"
  allocated_storage = 20
}
