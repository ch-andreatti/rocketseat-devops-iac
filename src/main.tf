
# Environments variables

locals {
  config = {

    "dev" = {

      tags = { "env" = "dev", iac = true }

      vpc = {
        cidr_block = "10.0.0.0/16"
      }

      subnet = {
        public_cidr_block  = "10.0.1.0/24"
        private_cidr_block = "10.0.2.0/24"
      }

    }

    "staging" = {

      tags = { "env" = "staging", iac = true }

      vpc = {
        cidr_block = "10.1.0.0/16"
      }

      subnet = {
        public_cidr_block  = "10.1.1.0/24"
        private_cidr_block = "10.1.2.0/24"
      }

    }

    "prod" = {

      tags = { "env" = "prod", iac = true }

      vpc = {
        cidr_block = "10.2.0.0/16"
      }

      subnet = {
        public_cidr_block  = "10.2.1.0/24"
        private_cidr_block = "10.2.2.0/24"
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
      Name = "${var.resource_prefix}_vpc_${terraform.workspace}"
    }
  )
}

module "public_subnet" {

  source = "./modules/subnet"

  vpc_id     = module.vpc.vpc_id
  cidr_block = local.workspace_config.subnet.public_cidr_block

  tags = merge(
    local.workspace_config.tags,
    {
      Name = "${var.resource_prefix}_public_subnet_${terraform.workspace}"
    }
  )

  depends_on = [module.vpc]
}

module "internet_gateway" {

  source = "./modules/internet_gateway"

  vpc_id = module.vpc.vpc_id

  tags = merge(
    local.workspace_config.tags,
    {
      Name = "${var.resource_prefix}_internet_gateway_${terraform.workspace}"
    }
  )

  depends_on = [module.vpc]
}

module "public_route_table" {

  source = "./modules/route_table"

  vpc_id    = module.vpc.vpc_id
  subnet_id = module.public_subnet.subnet_id

  tags = merge(
    local.workspace_config.tags,
    {
      Name = "${var.resource_prefix}_public_route_table_${terraform.workspace}"
    }
  )

  depends_on = [
    module.vpc,
    module.public_subnet
  ]
}

module "public_route" {

  source = "./modules/public_route"

  route_table_id         = module.public_route_table.route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = module.internet_gateway.internet_gateway_id

  depends_on = [
    module.internet_gateway,
    module.public_subnet
  ]
}

module "private_subnet" {

  source = "./modules/subnet"

  vpc_id     = module.vpc.vpc_id
  cidr_block = local.workspace_config.subnet.private_cidr_block

  tags = merge(
    local.workspace_config.tags,
    {
      Name = "${var.resource_prefix}_private_subnet_${terraform.workspace}"
    }
  )

  depends_on = [module.vpc]
}

module "elastic_ip" {

  source = "./modules/elastic_ip"

  tags = merge(
    local.workspace_config.tags,
    {
      Name = "${var.resource_prefix}_elastic_ip_${terraform.workspace}"
    }
  )
}

module "nat_gateway" {

  source = "./modules/nat_gateway"

  allocation_id = module.elastic_ip.elastic_ip_id
  subnet_id     = module.public_subnet.subnet_id

  tags = merge(
    local.workspace_config.tags,
    {
      Name = "${var.resource_prefix}_nat_gateway_${terraform.workspace}"
    }
  )

  depends_on = [
    module.public_subnet,
    module.elastic_ip
  ]
}

module "private_route_table" {

  source = "./modules/route_table"

  vpc_id    = module.vpc.vpc_id
  subnet_id = module.private_subnet.subnet_id

  tags = merge(
    local.workspace_config.tags,
    {
      Name = "${var.resource_prefix}_private_route_table_${terraform.workspace}"
    }
  )

  depends_on = [
    module.vpc,
    module.private_subnet
  ]
}
