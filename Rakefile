
# -*- ruby -*-

require 'rubygems'
require 'rubygems/package_task'
require 'rake/testtask'
require 'rdoc/task'
require 'bundler/gem_tasks'

$:.push File.expand_path(File.dirname(__FILE__), 'lib')

version = Webhookr::Mailchimp::VERSION

desc 'Test Webhookr Mailchimp'
Rake::TestTask.new(:test) do |t|
  t.test_files = FileList['test/**/*_tests.rb']
  t.verbose = !!ENV['VERBOSE_TESTS']
  t.warning = !!ENV['WARNINGS']
end

desc 'Build docs'
Rake::RDocTask.new do |t|
  t.main = 'README.md'
  t.title = "Webhookr Mailchimp #{version}"
  t.rdoc_dir = 'doc'
  t.rdoc_files.include('README.md', 'MIT-LICENSE', 'lib/**/*.rb')
end

namespace :webhookr do
  namespace:test do
    desc 'Install gems in all Rubies'
    task :install do
      sh %{rbenv each -v bundle install}
    end

    desc 'Test with all Rubies'
    task :test_versions do
      sh %{rbenv each -v bundle exec rake test}
    end

    desc 'Update rails'
    task :update_rails do
      sh %{rbenv each -v bundle update rails}
    end

    desc 'Install and test all'
    task :all => [:install, :test_versions]
  end
end

task :default => :test
