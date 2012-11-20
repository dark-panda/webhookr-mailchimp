# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'webhookr-mailchimp/version'

Gem::Specification.new do |gem|
  gem.name          = "webhookr-mailchimp"
  gem.version       = Webhookr::Services::Mailchimp::VERSION
  gem.authors       = ["Gerry Power"]
  gem.email         = ["gerry@zoocasa.com"]
  gem.description   = %q{TODO: Write a gem description}
  gem.summary       = %q{TODO: Write a gem summary}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency("activesupport", ["~> 3.1"])
  gem.add_dependency("recursive-open-struct")
  gem.add_development_dependency("rake")
  gem.add_development_dependency("minitest")
  gem.add_development_dependency("guard")
  gem.add_development_dependency("guard-minitest")
  gem.add_development_dependency("rb-fsevent")

end
