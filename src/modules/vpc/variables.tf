
variable "cidr_block" {
  type = string
}

variable "instance_tenancy" {
  type = string
}

variable "tags" {
  type = map(string)
}
