
resource "aws_db_instance" "exampleDB5" {
  Database_Name = "exampleDB5"
  Database Engine = "mysql"
  Environment = "Dev"
  instance_class = "db.t3.micro"
  allocated_storage = 20
}
