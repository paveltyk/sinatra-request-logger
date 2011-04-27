class HttpRequest
  include Mongoid::Document
  include Mongoid::Timestamps

  field :uri_string
end

