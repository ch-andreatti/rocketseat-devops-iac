
variable region {
  type        = string
  description = "Region of AWS that will be utilized"
}

variable aws_access_key {
  type        = string
}

variable aws_secret_key {
  type        = string
}

variable resource_prefix {
  type        = string
  description = "Prefix that will be utilized in the name of resources"
}
