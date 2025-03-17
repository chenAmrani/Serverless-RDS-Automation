
resource "aws_db_instance" "exampleDB1" {
  identifier = "exampleDB1"
  engine = "mysql"
  instance_class = "db.t3.medium"
  allocated_storage = 100
  tags = {
    Database_Name = "exampleDB1"
    Environment = "Prod"
  }
}
