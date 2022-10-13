# frozen_string_literal: true

require 'spec_helper'

describe 'account alias' do
  before(:context) do
    @account_alias = "test-account-#{SecureRandom.alphanumeric(4).downcase}"
    @plan = plan(role: :root) do |vars|
      vars.account_alias = @account_alias
    end
  end

  it 'sets the account alias to the provided value' do
    expect(@plan)
      .to(include_resource_creation(type: 'aws_iam_account_alias')
                .with_attribute_value(:account_alias, @account_alias))
  end
end
