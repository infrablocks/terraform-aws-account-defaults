require 'spec_helper'

describe 'password policy' do
  let(:minimum_password_length) { vars.minimum_password_length }

  let(:password_policy) {
    iam_client.get_account_password_policy({}).password_policy
  }

  it 'sets password length as expected' do
    actual_minimum_password_length = password_policy.minimum_password_length

    expect(actual_minimum_password_length)
        .to(be(minimum_password_length))
  end

  it 'allows diceware passwords' do
    expect(password_policy.require_lowercase_characters).to(be(false))
    expect(password_policy.require_uppercase_characters).to(be(false))
    expect(password_policy.require_numbers).to(be(false))
    expect(password_policy.require_symbols).to(be(false))
  end

  it 'allows users to change their own passwords' do
    expect(password_policy.allow_users_to_change_password).to(be(true))
  end

  it 'does not force password changes' do
    expect(password_policy.max_password_age).to(be_nil)
  end
end
