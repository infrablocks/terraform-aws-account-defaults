data "terraform_remote_state" "prerequisites" {
  backend = "local"

  config = {
    path = "${path.module}/../../../../state/prerequisites.tfstate"
  }
}

module "account_defaults" {
  # This makes absolutely no sense. I think there's a bug in terraform.
  source = "./../../../../../../../"

  account_alias = var.account_alias
  minimum_password_length = var.minimum_password_length
}
