class Issues < Base

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
    if ticket_id = params['ticket_id']
      ticket = settings.zendesk.tickets.find!(id: ticket_id)
      ticket.external_id = issue["url"]
      ticket.save
    end
    json issue.to_hash
  end
end
