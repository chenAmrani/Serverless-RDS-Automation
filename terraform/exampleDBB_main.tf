
resource "aws_db_instance" "exampleDBB" {
  Database_Name = "exampleDBB"
  Database Engine = "mysql"
  Environment = "Dev"
  instance_class = "db.t3.micro"
  allocated_storage = 20
}
