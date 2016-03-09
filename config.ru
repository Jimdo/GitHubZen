require 'rack'
require 'rack/contrib'
require './app/githubzen'

use Rack::PostBodyContentTypeParser

run GitHubZen
