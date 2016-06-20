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
    issue_url_matcher = params["issue"].match(/issues\/([0-9]*)/)
    issue_id = issue_url_matcher ? (issue_url_matcher[1]) : (params["issue"])
    comment = settings.octokit.add_comment(params["repo"], issue_id, body)
    json comment.to_hash
  end
end
