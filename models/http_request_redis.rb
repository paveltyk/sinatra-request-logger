require 'ostruct'

class HttpRequestRedis

  def self.connection
    @redis ||= Redis.new
  end

  def self.create(attributes)
    connection.lpush("http_requests", Marshal.dump(:created_at => Time.now, :uri_string => attributes[:uri_string]))
  end

  def self.recent(count)
    connection.lrange("http_requests", 0, count).map{|raw| OpenStruct.new(Marshal.load(raw))}
  end

end

