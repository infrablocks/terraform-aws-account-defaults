variable "account_alias" {
  type = string
  description = "The alias to use for the account."
}

variable "minimum_password_length" {
  type = number
  default = 32
  description = "The minimum password length for the account."
}
