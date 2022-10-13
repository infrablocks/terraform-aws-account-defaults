data "terraform_remote_state" "prerequisites" {
  backend = "local"

  config = {
    path = "${path.module}/../../../../state/prerequisites.tfstate"
  }
}

module "account_defaults" {
  source = "../../../.."

  account_alias = var.account_alias
  minimum_password_length = var.minimum_password_length
}
