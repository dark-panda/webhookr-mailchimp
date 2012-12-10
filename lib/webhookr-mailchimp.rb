require "webhookr"
require "webhookr-mailchimp/version"
require "active_support/core_ext/module/attribute_accessors"
require "recursive_open_struct"

module Webhookr
  module Mailchimp
    class Adapter
      SERVICE_NAME = 'mailchimp'
      EVENT_KEY = "type"
      RENAMED_EVENT_KEY = "event_key"
      PAYLOAD_KEY = "data"

      include Webhookr::Services::Adapter::Base

      def self.process(raw_response)
        new.process(raw_response)
      end

      def process(raw_response)
        Array.wrap(parse(raw_response)).collect do |p|
          Webhookr::AdapterResponse.new(
            SERVICE_NAME,
            p.fetch(RENAMED_EVENT_KEY),
            RecursiveOpenStruct.new(p, :recurse_over_arrays => true)
          )
        end
      end

      private

      def parse(raw_response)
        convert_event_key_to_ruby_friendly_name(
          assert_valid_packet(
            Rack::Utils.parse_nested_query(raw_response)
          )
        )
      end

      def convert_event_key_to_ruby_friendly_name(packet)
        # Ruby 1.8.7 fix for key 'type'
        rename = { EVENT_KEY => RENAMED_EVENT_KEY }
        Hash[packet.map {|k, v| [rename[k] || k, v] }]
      end

      def assert_valid_packet(parsed_response)
        raise(Webhookr::InvalidPayloadError,
              "Missing event key '#{EVENT_KEY}' in packet"
        ) unless parsed_response[EVENT_KEY].present?

        raise(Webhookr::InvalidPayloadError,
              "No data key '#{PAYLOAD_KEY}' in the response"
        ) unless parsed_response[PAYLOAD_KEY].present?

        parsed_response
      end

    end

  end
end
