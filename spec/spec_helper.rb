require 'rack/test'
require 'rspec'
require 'webmock/rspec'

ENV['RACK_ENV'] = 'test'

ENV['ZENDESK_URL'] = 'https://acme.zendesk.com/api/v2'
ENV['ZENDESK_USERNAME'] = 'zendesk_user'
ENV['ZENDESK_TOKEN'] = '123456789'

require File.expand_path '../../app/githubzen.rb', __FILE__
Dir[File.dirname(__FILE__) + "/support/**/*.rb"].each {|f| require f }

WebMock.disable_net_connect!(allow_localhost: true)

module RSpecMixin
  include Rack::Test::Methods
  def app() described_class end
end
RSpec.configure { |c| c.include RSpecMixin }

RSpec.configure do |config|
  config.before do
    stub_request(:any, /api.github.com/).to_rack(FakeGitHub)
    stub_request(:any, /zendesk.com/).to_rack(FakeZendesk)
  end
end
