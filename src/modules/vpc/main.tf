
resource "aws_vpc" "vpc" {

  cidr_block       = var.cidr_block
  instance_tenancy = var.instance_tenancy

  tags = var.tags
}