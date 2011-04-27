class RequestLoggerApp < Sinatra::Base
  helpers WillPaginate::ViewHelpers::Base
  get '/list' do
    @http_requests_total = HttpRequest.count
    @http_requests = HttpRequest.desc(:created_at).paginate :page => params[:page], :per_page => 100
    erb :list
  end

  get '/favicon.ico' do
  end

  get '*' do
    http_request = HttpRequest.new :uri_string => request.env['REQUEST_URI']
    http_request.save ? "success: #{http_request.uri_string}" : 'fail'
  end
end

