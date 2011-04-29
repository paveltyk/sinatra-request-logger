require 'ostruct'

class HttpRequestRedis

  class << self
    def connection
      @connection ||= Redis.new :db => 0
    end

    def create(attributes)
      mdump = Marshal.dump(:created_at => Time.now, :uri_string => attributes[:uri_string])
      connection.zadd("http_requests", Time.now.to_i, mdump)
    end

    def limit(qtt)
      connection.zrevrange("http_requests", 0, qtt).map{|raw| OpenStruct.new(Marshal.load(raw))}
    end

    def count
      connection.zcard("http_requests")
    end
  end
end

