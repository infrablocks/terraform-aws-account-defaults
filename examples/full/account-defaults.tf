module "account_defaults" {
  source = "../../"

  account_alias = "test-account-${lower(var.deployment_identifier)}"
  minimum_password_length = 28
}
