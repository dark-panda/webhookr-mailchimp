require "webhookr"
require "active_support/core_ext/module/attribute_accessors"
require "recursive_open_struct"

module Webhookr
  module Services
    module Mailchimp
      extend ActiveSupport::Autoload

      autoload :VERSION

      mattr_accessor :config
      self.config = ActiveSupport::OrderedOptions.new

      class Adapter
        EVENT_KEY = "type"
        PAYLOAD_KEY = "data"

        def self.process(raw_response)
          new.process(raw_response)
        end

        def process(raw_response)
          p = parse(raw_response)
          return [ Webhookr::AdapterResponse.new(p[EVENT_KEY], RecursiveOpenStruct.new(p)) ]
        end

        private

        def parse(raw_response)
          assert_valid_packet(Rack::Utils.parse_nested_query(raw_response))
        end

        def assert_valid_packet(parsed_response)
          raise(Webhookr::InvalidPayloadError, "Missing event key '#{EVENT_KEY}' in packet") unless parsed_response[EVENT_KEY].present?
          raise(Webhookr::InvalidPayloadError, "No data key '#{PAYLOAD_KEY}' in the response") unless parsed_response[PAYLOAD_KEY].present?
          parsed_response
        end

      end

    end
  end
end
