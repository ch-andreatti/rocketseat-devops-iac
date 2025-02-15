
resource "aws_subnet" "subnet" {
  vpc_id     = var.vpc_id
  cidr_block = var.cidr_block

  tags = {
    name        = "${var.resource_prefix}-subnet-${terraform.workspace}"
    iac         = true,
    environment = "${terraform.workspace}"
  }
}
