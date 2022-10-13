locals {
  # default for cases when `null` value provided, meaning "use default"
  minimum_password_length = var.minimum_password_length == null ? 32 : var.minimum_password_length
}