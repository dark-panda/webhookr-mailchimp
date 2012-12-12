module Webhookr
  module Mailchimp
    module Generators

      class ExampleHooksGenerator < Rails::Generators::Base
        source_root File.expand_path(File.join(File.dirname(__FILE__), 'templates'))

        desc "Creates an example Mailchimp hook file: 'app/models/mail_chimp_hooks.rb'"
        def example_hooks
          copy_file( "mail_chimp_hooks.rb", "app/models/mail_chimp_hooks.rb")
        end
      end

    end
  end
end
