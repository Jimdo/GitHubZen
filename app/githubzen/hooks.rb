class Hooks < Base
  post '/hooks' do
    return halt 406, 'Only "issue_comment" supported yet' unless params['action'] == "created"
    body = erb :ticket, locals: {
      text: params['comment']['body'],
      developer: settings.octokit.user(params['comment']['user']['login']),
      issue: params['issue']
    }
    ticket = settings.zendesk.search(query: "type:ticket external_id:#{params['issue']['url']}").first
    ticket.comment = { value: body, public: false }
    ticket.save!
    [200, ['']]
  end
end
