#!/usr/bin/env rake
require "bundler/gem_tasks"
require 'rake/testtask'

Rake::TestTask.new do |t|
  t.libs << 'lib/webhookr-mailchimp'
  t.test_files = FileList['test/unit/**/*_test.rb']
  t.verbose = true
end

task :default => :test