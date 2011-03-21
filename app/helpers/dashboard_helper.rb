module DashboardHelper
  
  def humanize_action(action)
    case action
    when 'ticket.solved'
      "You solved a Zendesk ticket"
    when 'item.created'
      "You created an item on Podio"
    else
      "You did some stuff"
    end
  end
  
end
