source 'https://rubygems.org'

gemspec

gem "recursive-open-struct", "0.3.1", :github => "gerrypower/recursive-open-struct"
gem "rake", "~> 10.0"
gem "minitest"
gem "minitest-reporters"
gem "em-websocket"
gem "guard"
gem "guard-minitest"
gem "guard-markdown"
gem "guard-livereload"

if RbConfig::CONFIG['host_os'] =~ /^darwin/
  gem "rb-fsevent"
  gem "growl"
end

if File.exists?('Gemfile.local')
  instance_eval File.read('Gemfile.local')
end

