require 'bundler/setup'
Bundler.require(:default)

class GitHubZen < Sinatra::Application

  set :octokit, Octokit::Client.new(:access_token => ENV['GITHUB_TOKEN'])
  set :token, Proc.new { ENV['TOKEN'] || raise('ENV["TOKEN"] needs to be set') }
  set :views, 'templates'

  configure :development do
    register Sinatra::Reloader
  end

  before do
    halt 401, 'go away!' unless params['token'] == settings.token
  end

  post '/issues' do
    body = erb :issue, locals: {
      text: params['body'],
      agent_name: params['agent_name'],
      agent_email: params['agent_email']
    }
    issue = settings.octokit.create_issue(
      params["repo"], params["title"], body, labels: params["labels"]
    )
    json issue.to_hash
  end
end
