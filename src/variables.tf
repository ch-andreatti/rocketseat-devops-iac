
variable "region" {
  type        = string
  description = "Region of AWS that will be utilized"
}

variable "aws_access_key" {
  type        = string
  description = "AWS access key"
}

variable "aws_secret_key" {
  type        = string
  description = "AWS secret key"
}

variable "resource_prefix" {
  type        = string
  description = "Prefix that will be utilized in the name of resources"
}
