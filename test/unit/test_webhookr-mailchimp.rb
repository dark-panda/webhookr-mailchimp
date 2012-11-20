
$: << File.dirname(__FILE__)
require 'test_helper'

describe Webhookr::Services::Mailchimp do
  subject { Webhookr::Services::Mailchimp }
  
  describe "configuration" do
    
    it "must respond to config" do
      subject.must_respond_to(:config)
    end

    it "must respond to config.callback" do
      subject.config.must_respond_to(:callback)
    end
  end
  
end

describe Webhookr::Services::Mailchimp::Adapter do
  
  before do
    @event_type = "unsubscribe"
    @fired_at = "2009-03-26 22:01:00"
    @valid_response = "type=#{@event_type}&fired_at=#{@fired_at}&data[email]=gerry%2Bagent2@zoocasa.com"
  end

  subject { Webhookr::Services::Mailchimp::Adapter.new }

  it "must support process" do
    subject.must_respond_to(:process)
  end

  it "should not return an error for a valid packet" do
    lambda {
      subject.process(@valid_response)
    }.must_be_silent
  end

  it "should return the correct event type" do
    response = subject.process(@valid_response).first
    assert_equal(@event_type, response.event_type)
  end

  it "should return the correct data packet" do
    response = subject.process(@valid_response).first
    assert_equal("gerry+agent2@zoocasa.com", response.payload.data.email)
  end

  it "should raise MailObserver::InvalidPayloadError for no packet" do
    lambda {
      subject.process("")
    }.must_raise(Webhookr::InvalidPayloadError)
  end

  it "should raise MailObserver::InvalidProtocolError for a missing event type" do
    lambda {
      subject.process("data[email]=gerry%2Bagent2@zoocasa.com")
    }.must_raise(Webhookr::InvalidPayloadError)
  end

  it "should raise MailObserver::InvalidProtocolError for a missing data packet" do
    lambda {
      subject.process("type=unsubscribe")
    }.must_raise(Webhookr::InvalidPayloadError)
  end

end
