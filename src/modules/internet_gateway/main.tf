
resource "aws_internet_gateway" "ig" {

  vpc_id = var.vpc_id

  tags = var.tags
}
