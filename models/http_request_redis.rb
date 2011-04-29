require 'ostruct'

class HttpRequestRedis

  def self.connection
    @redis ||= Redis.new
  end

  def self.create(attributes)
    connection.lpush("http_requests", Marshal.dump(:created_at => Time.now, :uri_string => attributes[:uri_string]))
  end

  def self.paginate(params = {})
    total_entries = connection.llen("http_requests")
    WillPaginate::Collection.create(params[:page] || 1, params[:per_page] || 1000, total_entries) do |c|
      records = connection.lrange("http_requests", c.offset, c.offset + c.per_page)
      records.map!{|raw| OpenStruct.new(Marshal.load(raw))}
      c.replace(records)
    end
  end

  def self.recent(count)
    connection.lrange("http_requests", 0, count).map{|raw| OpenStruct.new(Marshal.load(raw))}
  end

end
