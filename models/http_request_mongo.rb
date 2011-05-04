class HttpRequestMongo
  include Mongoid::Document
  include Mongoid::Timestamps::Created

  store_in :http_requests
  field :uri_string
  field :mod, :type => Integer
  index :created_at, :background => true

  before_save :generate_mod

  private

  def generate_mod
    self.mod = rand(2)
  end
end

