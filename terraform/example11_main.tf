
resource "aws_db_instance" "example11" {
  identifier       = "example11"
  engine           = "mysql"
  instance_class   = "db.t3.micro"
  allocated_storage = 20
  
  username         = "admin"           
  password         = "examplePass" 

  tags = {
    Environment = "Dev"
  }
}
