require 'sinatra/base'

class FakeZendesk < Sinatra::Base
  get '/api/v2/tickets/:id' do
    json_response 200, 'ticket.json'
  end

  put '/api/v2/tickets/:id' do
    json_response 200, 'update_ticket.json'
  end

  get '/api/v2/search' do
    json_response 200, 'search_result.json'
  end

  private

  def json_response(response_code, file_name)
    content_type :json
    status response_code
    File.open(File.dirname(__FILE__) + '/../fixtures/' + file_name, 'rb').read
  end
end
