require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require 'minitest/reporters'
require 'rails'
require "rails/generators/test_case"
require File.expand_path('../../lib/webhookr-mailchimp.rb', __FILE__)

if RUBY_VERSION >= "1.9"
  MiniTest::Reporters.use!(MiniTest::Reporters::SpecReporter.new)
end

puts "Webhookr #{Webhookr::VERSION}"
puts "Webhookr::Mailchimp #{Webhookr::Mailchimp::VERSION}"
puts "Rails #{Rails::VERSION::STRING}"
puts "Ruby #{RUBY_VERSION}-p#{RUBY_PATCHLEVEL} - #{RbConfig::CONFIG['RUBY_INSTALL_NAME']}"

