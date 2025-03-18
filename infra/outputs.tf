output "rds_endpoint" {
  value = aws_db_instance.rds_instance.endpoint
}

output "rds_db_name" {
  value = aws_db_instance.rds_instance.db_name
}

output "rds_instance_id" {
  value = aws_db_instance.rds_instance.id
}