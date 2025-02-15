
variable "vpc_id" {
  type = string
}

variable "cidr_block" {
  type = string
}

variable "resource_prefix" {
  type        = string
  description = "Prefix that will be utilized in the name of resources"
}
