Mongoid.configure do |config|
  config.master = Mongo::Connection.new.db("request_logger_app")
  config.allow_dynamic_fields = false
end

