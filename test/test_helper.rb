require 'minitest/autorun'
require 'minitest/reporters'
require 'rails'
require File.expand_path('../../lib/webhookr-mailchimp.rb', __FILE__)

if RUBY_VERSION >= "1.9"
  MiniTest::Reporters.use!(MiniTest::Reporters::SpecReporter.new)
end
