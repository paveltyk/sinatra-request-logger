class HttpRequestMongo
  include Mongoid::Document
  include Mongoid::Timestamps::Created

  store_in :http_requests
  field :uri_string
end

