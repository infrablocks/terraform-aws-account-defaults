variable "region" {}

variable "account_alias" {
  type    = string
  default = null
}

variable "minimum_password_length" {
  type        = number
  default     = null
}
