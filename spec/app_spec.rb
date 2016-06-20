require 'spec_helper.rb'

describe GitHubZen do

  let(:token) { "EGC2Ech2tErNXMwTr2" }
  let(:zendesk_params) {{
    "token" => token,
    "ticket_id" => 272159,
    "repo" => "Jimdo/template-chicago",
    "agent_name" => "Hannah V. Glock",
    "agent_email" => "hannah@jimdo.com",
    "title" => "Move logo 3px right",
    "body" => "The logo has shifted, the customer would love to see that corrected.",
    "labels" => ["bug", "zendesk"]
  }}

  let(:comment_zendesk_params) {{
    "token" => token,
    "repo" => "Jimdo/template-chicago",
    "agent_name" => "Hannah V. Glock",
    "agent_email" => "hannah@jimdo.com",
    "issue" => "https://github.com/org/repo/issues/33",
    "comment" => "dummy comment"
  }}

  before do
    ENV['TOKEN'] = token
  end

  it 'posts issues to github' do
    post '/issues', zendesk_params

    expect(last_response).to be_ok

    response = JSON.parse last_response.body
    expect(response['id']).to be 1
  end

  it 'posts comments to github' do
    post '/comments', comment_zendesk_params

    expect(last_response).to be_ok

    response = JSON.parse last_response.body
    expect(response['id']).to be 1
  end

  context 'with invalid token' do
    it 'returns 401 Unauthorized if issues requested' do
      zendesk_params['token'] = zendesk_params['token'] + "-invalidate!"
      post '/issues', zendesk_params
      expect(last_response).to be_unauthorized
    end

    it 'returns 401 Unauthorized if comments requested' do
      comment_zendesk_params['token'] = comment_zendesk_params['token'] + "-invalidate!"
      post '/comments', comment_zendesk_params
      expect(last_response).to be_unauthorized
    end
  end
end
