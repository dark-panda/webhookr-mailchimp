
$: << File.join(File.dirname(__FILE__), "..")
require 'test_helper'

describe Webhookr::Mailchimp::Adapter do
  
  before do
    @event_type = "unsubscribe"
    @fired_at = "2009-03-26 22:01:00"
    @valid_response = "type=#{@event_type}&fired_at=#{@fired_at}&data[email]=gerry%2Bagent2@zoocasa.com"
  end

  describe "the class" do

    subject { Webhookr::Mailchimp::Adapter }

    it "must support process" do
      subject.must_respond_to(:process)
    end

    it "should not return an error for a valid packet" do
      lambda {
        subject.process(@valid_response)
      }.must_be_silent
    end

  end

  describe "the instance" do

    subject { Webhookr::Mailchimp::Adapter.new }

    it "should not return an error for a valid packet" do
      lambda {
        subject.process(@valid_response)
      }.must_be_silent
    end

    it "should raise Webhookr::InvalidPayloadError for no packet" do
      lambda {
        subject.process("")
      }.must_raise(Webhookr::InvalidPayloadError)
    end

    it "should raise Webhookr::InvalidPayloadError for a missing event type" do
      lambda {
        subject.process("data[email]=gerry%2Bagent2@zoocasa.com")
      }.must_raise(Webhookr::InvalidPayloadError)
    end

    it "should raise Webhookr::InvalidPayloadError for a missing data packet" do
      lambda {
        subject.process("type=unsubscribe")
      }.must_raise(Webhookr::InvalidPayloadError)
    end

  end

  describe "it's response" do
    before do
      @event_type = "unsubscribe"
      @adapter = Webhookr::Mailchimp::Adapter.new
    end

    subject { @adapter.process(@valid_response).first }

    it "must respond to service_name" do
      subject.must_respond_to(:service_name)
    end

    it "should return the correct service name" do
      assert_equal(Webhookr::Mailchimp::Adapter::SERVICE_NAME, subject.service_name)
    end

    it "must respond to event_type" do
      subject.must_respond_to(:event_type)
    end

    it "should return the correct event type" do
      assert_equal(@event_type, subject.event_type)
    end

    it "must respond to payload" do
      subject.must_respond_to(:payload)
    end

    it "must respond to payload.data" do
      subject.payload.must_respond_to(:data)
    end

    it "should return the correct data packet" do
      assert_equal("gerry+agent2@zoocasa.com", subject.payload.data.email)
    end

  end

end
