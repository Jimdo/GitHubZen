require 'spec_helper.rb'

describe GitHubZen do

  let(:github_params) { JSON.parse File.open(File.dirname(__FILE__) + '/fixtures/issue_comment-hook.json', 'rb').read }

  it 'receives hooks from github and posts it to zendesk' do
    post '/hooks', github_params

    expect(last_response).to be_ok
  end
end
