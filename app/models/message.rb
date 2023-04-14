# frozen_string_literal: true

class Message < ApplicationRecord
  belongs_to :conversation
  belongs_to :sender, polymorphic: true
  belongs_to :receiver, polymorphic: true

  before_validation :set_receiver
  after_create_commit :broadcast_message

  def set_receiver
    self.receiver = if sender_id.eql?(conversation.borrower_id)
                      conversation.lender
                    else
                      conversation.borrower
                    end
  end

  def broadcast_message
    conversation_id = conversation.id
    ActionCable.server.broadcast "conversation_#{conversation_id}",
                                 { object: { content: content,
                                             sender_type: sender_type,
                                             sender_id: sender_id,
                                             sender_name: sender_name,
                                             conversation_id: conversation_id,
                                             created_at: created_at } }
    notify_receiver unless receiver.online.value.eql?(true)
  end

  def sender_name
    sender.full_name
  end

  def notify_receiver
    I18n.with_locale(receiver.locale || I18n.default_locale) do
      Notification.create(
        content: I18n.t('notifications.messages.new_message.content',
                        sender_name: sender_name),
        payload: {
          title: I18n.t('notifications.messages.new_message.title'),
          subject: I18n.t('notifications.messages.new_message.content',
                          sender_name: sender_name),
          type: 'new_message',
          conversation_id: conversation_id
        },
        recipient: receiver
      )
    end
  end
end
