require 'bundler/setup'
Bundler.require(:default)

require './app/githubzen/base'
require './app/githubzen/welcome'
require './app/githubzen/hooks'
require './app/githubzen/issues'
require './app/githubzen/comments'

class GitHubZen < Sinatra::Application
  use Welcome
  use Hooks
  use Issues
  use Comments
end
