require 'spec_helper'

describe 'account alias' do
  let(:account_alias) { vars.account_alias }

  it 'sets account alias as expected' do
    actual_account_aliases =
        iam_client.list_account_aliases({}).account_aliases

    expect(actual_account_aliases).to(include(account_alias))
  end
end
