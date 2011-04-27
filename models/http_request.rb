class HttpRequest
  include Mongoid::Document
  include Mongoid::Timestamps::Created

  field :uri_string
end

