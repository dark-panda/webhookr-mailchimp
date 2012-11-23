require 'minitest/autorun'
require 'minitest/reporters'
require 'rails'
require File.expand_path('../../lib/webhookr-mailchimp.rb', __FILE__)

MiniTest::Reporters.use!(MiniTest::Reporters::SpecReporter.new)

