require 'rubygems' if RUBY_VERSION < "1.9"
require 'bundler'

Bundler.require

Dir['./initializers/**/*.rb'].each { |f| require f }
Dir['./models/**/*.rb'].each { |f| require f }

require './request_logger_app'

run RequestLoggerApp

