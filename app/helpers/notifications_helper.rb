# frozen_string_literal: true

module NotificationsHelper
  def notification_path(notification)
    case notification.payload['type']
    when 'request_accepted'
      conversation_messages_path(notification.payload['conversation_id'])
    when 'borrow_request'
      lend_requests_path
    when 'lend_requests'
      borrow_requests_path
    end
  end
end
