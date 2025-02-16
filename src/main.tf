
# Environments variables

locals {
  config = {

    "dev" = {

      tags = { "env" = "dev", iac = true }

      subnet = {
        cidr_block_public  = "10.0.1.0/24"
        cidr_block_private = "10.0.2.0/24"
      }

    }

    "staging" = {

      tags = { "env" = "staging", iac = true }

      subnet = {
        cidr_block_public  = "10.0.3.0/24"
        cidr_block_private = "10.0.4.0/24"
      }

    }

    "prod" = {

      tags = { "env" = "prod", iac = true }

      subnet = {
        cidr_block_public  = "10.0.5.0/24"
        cidr_block_private = "10.0.6.0/24"
      }

    }

  }
  workspace_config = lookup(local.config, terraform.workspace, local.config["dev"])
}

# Infrastructure definition

# Network

resource "aws_vpc" "vpc_main" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = merge(
    local.workspace_config.tags,
    {
      name = "${var.resource_prefix}-vpc-main"
    }
  )
}

module "subnet-private" {
  source     = "./modules/subnet"
  vpc_id     = aws_vpc.vpc_main.id
  cidr_block = local.workspace_config.subnet.cidr_block_private

  tags = merge(
    local.workspace_config.tags,
    {
      name = "${var.resource_prefix}-subnet-private-${terraform.workspace}"
    }
  )

  depends_on = [aws_vpc.vpc_main]
}
