# frozen_string_literal: true

require 'spec_helper'

describe 'password policy' do
  describe 'by default' do
    before(:context) do
      @account_alias = "test-account-#{SecureRandom.alphanumeric(4).downcase}"
      @plan = plan(role: :root) do |vars|
        vars.account_alias = @account_alias
      end
    end

    it 'allows diceware passwords' do
      expect(@plan)
        .to(include_resource_creation(type: 'aws_iam_account_password_policy')
              .with_attribute_value(:require_uppercase_characters, false)
              .with_attribute_value(:require_lowercase_characters, false)
              .with_attribute_value(:require_numbers, false)
              .with_attribute_value(:require_symbols, false))
    end

    it 'allows users to change their own passwords' do
      expect(@plan)
        .to(include_resource_creation(type: 'aws_iam_account_password_policy')
              .with_attribute_value(:allow_users_to_change_password, true))
    end

    it 'uses a password length of 32' do
      expect(@plan)
        .to(include_resource_creation(type: 'aws_iam_account_password_policy')
              .with_attribute_value(:minimum_password_length, 32))
    end

    it 'does not force password changes' do
      expect(@plan)
        .to(include_resource_creation(type: 'aws_iam_account_password_policy')
              .with_attribute_value(:max_password_age, 0))
    end
  end

  describe 'when minimum password length provided' do
    before(:context) do
      @account_alias = "test-account-#{SecureRandom.alphanumeric(4).downcase}"
      @plan = plan(role: :root) do |vars|
        vars.account_alias = @account_alias
        vars.minimum_password_length = 24
      end
    end

    it 'uses the specified password length' do
      expect(@plan)
        .to(include_resource_creation(type: 'aws_iam_account_password_policy')
              .with_attribute_value(:minimum_password_length, 24))
    end
  end
end
