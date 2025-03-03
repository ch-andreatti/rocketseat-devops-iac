
# Environments variables

locals {
  config = {

    "dev" = {

      tags = { "env" = "dev", iac = true }

      vpc = {
        cidr_block = "10.0.0.0/16"
      }

      subnet = {
        cidr_block_public  = "10.0.1.0/24"
        cidr_block_private = "10.0.2.0/24"
      }

    }

    "staging" = {

      tags = { "env" = "staging", iac = true }

      vpc = {
        cidr_block = "10.1.0.0/16"
      }

      subnet = {
        cidr_block_public  = "10.1.1.0/24"
        cidr_block_private = "10.1.2.0/24"
      }

    }

    "prod" = {

      tags = { "env" = "prod", iac = true }

      vpc = {
        cidr_block = "10.2.0.0/16"
      }

      subnet = {
        cidr_block_public  = "10.2.1.0/24"
        cidr_block_private = "10.2.2.0/24"
      }

    }

  }
  workspace_config = lookup(local.config, terraform.workspace, local.config["dev"])
}

# Infrastructure definition

# Network

module "vpc" {

  source = "./modules/vpc"

  cidr_block       = local.workspace_config.vpc.cidr_block
  instance_tenancy = "default"

  tags = merge(
    local.workspace_config.tags,
    {
      Name = "${var.resource_prefix}-vpc-${terraform.workspace}"
    }
  )
}

module "subnet-public" {

  source = "./modules/subnet"

  vpc_id     = module.vpc.vpc_id
  cidr_block = local.workspace_config.subnet.cidr_block_public

  tags = merge(
    local.workspace_config.tags,
    {
      Name = "${var.resource_prefix}-subnet-public-${terraform.workspace}"
    }
  )

  depends_on = [module.vpc]
}
