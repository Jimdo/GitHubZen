class Base < Sinatra::Application

  set :octokit, Octokit::Client.new(:access_token => ENV['GITHUB_TOKEN'])
  set(:zendesk, ZendeskAPI::Client.new do |config|
    config.url = ENV['ZENDESK_URL']
    config.username = ENV['ZENDESK_USERNAME'] # Basic / Token Authentication
    config.token = ENV['ZENDESK_TOKEN'] # Choose one of the following depending on your authentication choice
  end)
  set :token, Proc.new { ENV['TOKEN'] || raise('ENV["TOKEN"] needs to be set') }
  set :views, 'templates'

  configure :development do
    register Sinatra::Reloader
  end

end
