require 'rubygems' if RUBY_VERSION < "1.9"
require 'bundler'

Bundler.require

Dir['./config/initializers/**/*.rb'].each { |f| require f }
Dir['./models/**/*.rb'].each { |f| require f }

require './application'

run Application

