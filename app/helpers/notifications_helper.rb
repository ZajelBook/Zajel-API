module NotificationsHelper
  def notification_path(notification)
    case notification.payload.type
    when 'new_message'
      conversation_messages_path(notification.payload.conversation_id)
    when 'borrow_request'
      book_activities_path(type: 'received')
    when 'lend_requests'
      book_activities_path(type: 'sent')
    end
  end
end