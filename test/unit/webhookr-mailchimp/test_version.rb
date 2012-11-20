require_relative '../../test_helper'

describe Webhookr::Services::Mailchimp do
  it "must be defined" do
    Webhookr::Services::Mailchimp::VERSION.wont_be_nil
  end
end