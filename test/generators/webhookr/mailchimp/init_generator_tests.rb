
$: << File.join(File.dirname(__FILE__), %w{ .. .. })
require 'test_helper'
require 'generators/webhookr/mailchimp/init_generator'

class InitGeneratorTests < Rails::Generators::TestCase
  tests Webhookr::Mailchimp::Generators::InitGenerator
  destination File.expand_path("../../../tmp", File.dirname(__FILE__))
  setup :prepare_destination

  def setup
    @name = "test_initializer"
    @initializer = "config/initializers/#{@name}.rb"
    run_generator Array.wrap(@name)
  end

  test "it should create the initializer" do
    assert_file @initializer
  end

  test "it should have authorization information" do
    assert_file @initializer do |content|
      assert_match(%r{Webhookr::Mailchimp::Adapter\.config\.security_token}, content)
    end
  end
end