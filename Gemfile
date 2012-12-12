source 'https://rubygems.org'

gemspec

group :development, :test do
  gem "rake", "~> 10.0"
  gem "minitest"
  gem "minitest-reporters"
  gem "em-websocket"
  gem "guard"
  gem "guard-minitest"
  gem "guard-markdown"
  gem "guard-livereload"
  gem "simplecov", :require => false
  if RbConfig::CONFIG['host_os'] =~ /^darwin/
    gem "rb-fsevent"
    gem "growl"
  end
end

if File.exists?('Gemfile.local')
  instance_eval File.read('Gemfile.local')
end

