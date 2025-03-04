
resource "aws_nat_gateway" "nat_gateway" {

  connectivity_type = "public"
  allocation_id     = var.allocation_id
  subnet_id         = var.subnet_id

  tags = var.tags
}
