
resource "aws_eip" "elastic_ip" {

  domain = "vpc"

  tags = var.tags
}