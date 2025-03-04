
variable "allocation_id" {
  type        = string
  description = "ID of elastic IP"
}

variable "subnet_id" {
  type = string
}

variable "tags" {
  type = map(string)
}
