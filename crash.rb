begin
  require 'bundler/inline'
rescue LoadError => e
  $stderr.puts 'Bundler version 1.10 or later is required. Please update your Bundler'
  raise e
end

gemfile(true) do
  ruby '2.3.0'
  source 'https://rubygems.org'
  gem 'activerecord', '4.2.5'
end

require 'active_record'

{ foo: ActiveRecord::Base }.dig(:foo, :bar)
