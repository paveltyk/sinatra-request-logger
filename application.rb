class Application < Sinatra::Base
  helpers WillPaginate::ViewHelpers::Base

  get '/mongo/list' do
    @http_requests_total = HttpRequestMongo.count
    @http_requests = HttpRequestMongo.desc(:created_at).paginate :page => params[:page], :per_page => 100
    erb :list
  end

  get '/mongo/create' do
    qtt = (params[:qtt] || 1).to_i
    qtt.times { HttpRequestMongo.create :uri_string => request.env['REQUEST_URI'] }
    "Created records: #{qtt}"
  end

  get '/mysql/list' do
    @http_requests_total = HttpRequestAR.count
    @http_requests = HttpRequestAR.order('created_at DESC').paginate :page => params[:page], :per_page => 100
    erb :list
  end

  get '/mysql/create' do
    qtt = (params[:qtt] || 1).to_i
    qtt.times { HttpRequestAR.create :uri_string => request.env['REQUEST_URI'] }
    "Created records: #{qtt}"
  end

  get '/blank/list' do
    @http_requests_total = 0
    @http_requests = [].paginate :page => params[:page], :per_page => 100
    erb :list
  end

  get '/blank/create' do
    qtt = (params[:qtt] || 1).to_i
    "Created records: #{qtt}"
  end
end

