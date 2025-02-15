
resource "aws_vpc" "vpc_main" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    name = "${var.resource_prefix}-vpc-main",
    iac  = true
  }
}

module "network" {
  source          = "./modules/vpc"
  vpc_id          = aws_vpc.vpc_main.id
  cidr_block      = "10.0.1.0/24"
  resource_prefix = var.resource_prefix
  depends_on      = [aws_vpc.vpc_main]
}
