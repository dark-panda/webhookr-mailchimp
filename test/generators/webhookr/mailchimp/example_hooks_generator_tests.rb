
$: << File.join(File.dirname(__FILE__), %w{ .. .. .. })
require 'test_helper'
require 'generators/webhookr/mailchimp/example_hooks_generator'

class ExampleHooksGeneratorTests < Rails::Generators::TestCase
  tests Webhookr::Mailchimp::Generators::ExampleHooksGenerator
  destination File.expand_path("../../../tmp", File.dirname(__FILE__))
  setup :prepare_destination

  def setup
    run_generator
  end

  test "it should create the example hook file" do
    assert_file "app/models/mail_chimp_hooks.rb"
  end

  test "it should on handlers" do
    assert_file "app/models/mail_chimp_hooks.rb" do |content|
      assert_match(%r{on_subscribe.*on_unsubscribe.*on_profile.*on_upemail.*on_cleaned.*on_campaign}m, content)
    end
  end
end