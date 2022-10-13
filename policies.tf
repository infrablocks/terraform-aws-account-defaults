resource "aws_iam_account_password_policy" "iam_password_policy" {
  minimum_password_length = local.minimum_password_length

  // Allow diceware passwords
  require_lowercase_characters = false
  require_numbers = false
  require_uppercase_characters = false
  require_symbols = false

  // Follow NIST recommendations
  // https://github.com/usnistgov/800-63-3
  max_password_age = 0

  allow_users_to_change_password = true
}
