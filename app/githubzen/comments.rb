class Comments < Base

  before do
    halt 401, 'go away!' unless params['token'] == settings.token
  end

  post '/comments' do
    body = erb :issue, locals: {
      text: params['comment'],
      agent_name: params['agent_name'],
      agent_email: params['agent_email']
    }
    comment = settings.octokit.add_comment(
      params["repo"], params["issue"], body
    )
    json comment.to_hash
  end
end
