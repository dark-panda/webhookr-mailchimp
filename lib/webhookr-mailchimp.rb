require "webhookr-mailchimp/version"
require "webhookr"
require "active_support/core_ext/module/attribute_accessors"
require "recursive_open_struct"
require "webhookr/invalid_payload_error"

module Webhookr
  module Services
    module Mailchimp
      mattr_accessor :config
      self.config = ActiveSupport::OrderedOptions.new

      class Adapter
        EVENT_KEY = "type"
        EVENT_DATE_KEY = "fired_at"
        PAYLOAD_KEY = "data"

        def process(raw_response)
          p = Rack::Utils.parse_nested_query(raw_response)
          assert_valid_packet(p)

          return [ OpenStruct.new(
                      :event_type => p[EVENT_KEY],
                      :payload => RecursiveOpenStruct.new(p, :recurse_over_arrays => true)
                    )
                 ]
        end

        private

        def assert_valid_packet(parsed_response)
          raise(Webhookr::InvalidPayloadError, "Missing event key '#{EVENT_KEY}' in packet") unless parsed_response[EVENT_KEY].present?
          raise(Webhookr::InvalidPayloadError, "No data key '#{PAYLOAD_KEY}' in the response") unless parsed_response[PAYLOAD_KEY].present?
        end

      end
    end
  end
end
