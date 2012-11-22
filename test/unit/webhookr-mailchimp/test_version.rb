require_relative '../../test_helper'

describe Webhookr::Mailchimp do
  it "must be defined" do
    Webhookr::Mailchimp::VERSION.wont_be_nil
  end
end