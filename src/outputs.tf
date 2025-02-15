
output "vpc_main_id" {
  value     = aws_vpc.vpc_main.id
  sensitive = true
}
