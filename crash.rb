require 'rubygems'
require 'bundler/setup'
require 'active_record'

{ foo: ActiveRecord::Base }.dig(:foo, :bar)
