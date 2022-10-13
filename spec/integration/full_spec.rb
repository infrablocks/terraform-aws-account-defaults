# frozen_string_literal: true

require 'spec_helper'

describe 'full' do
  before(:context) do
    apply(role: :full)
  end

  after(:context) do
    destroy(role: :full)
  end

  let(:deployment_identifier) do
    var(role: :full, name: 'deployment_identifier')
  end

  describe 'account alias' do
    it 'sets account alias as expected' do
      actual_account_aliases =
        iam_client.list_account_aliases({}).account_aliases

      expect(actual_account_aliases)
        .to(include("test-account-#{deployment_identifier.downcase}"))
    end
  end

  describe 'password policy' do
    let(:password_policy) do
      iam_client.get_account_password_policy({}).password_policy
    end

    it 'sets password length as expected' do
      actual_minimum_password_length = password_policy.minimum_password_length

      expect(actual_minimum_password_length)
        .to(be(28))
    end

    # rubocop:disable RSpec/MultipleExpectations
    it 'allows diceware passwords' do
      expect(password_policy.require_lowercase_characters).to(be(false))
      expect(password_policy.require_uppercase_characters).to(be(false))
      expect(password_policy.require_numbers).to(be(false))
      expect(password_policy.require_symbols).to(be(false))
    end
    # rubocop:enable RSpec/MultipleExpectations

    it 'allows users to change their own passwords' do
      expect(password_policy.allow_users_to_change_password).to(be(true))
    end

    it 'does not force password changes' do
      expect(password_policy.max_password_age).to(be_nil)
    end
  end
end
