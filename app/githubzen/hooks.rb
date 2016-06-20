class Hooks < Base
  post '/hooks' do
    return halt 406, 'Only "issue_comment" supported yet' unless params['action'] == "created"
    user = params['comment']['user']['login']
    unless user == ENV['GITHUB_BOT_USER'] then
      body = erb :ticket, locals: {
        text: params['comment']['body'],
        developer: settings.octokit.user(user),
        issue: params['issue']
      }
      ticket = settings.zendesk.search(query: "type:ticket external_id:#{params['issue']['url']}").first
      ticket.comment = { value: body, public: false }
      ticket.save!
    end
    [200, ['']]
  end
end
