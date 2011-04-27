class RequestLoggerApp < Sinatra::Base
  helpers WillPaginate::ViewHelpers::Base

  get '/mongo/list' do
    @http_requests_total = HttpRequest.count
    @http_requests = HttpRequest.desc(:created_at).paginate :page => params[:page], :per_page => 1000
    erb :list
  end

  get '/mongo/create' do
    qtt = (params[:qtt] || 1).to_i
    qtt.times { HttpRequest.create :uri_string => request.env['REQUEST_URI'] }
    "Creted records: #{qtt}"
  end
end

