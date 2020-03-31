class Message < ApplicationRecord
  belongs_to :conversation
  belongs_to :sender, polymorphic: true
  belongs_to :receiver, polymorphic: true

  before_validation :set_receiver
  after_create :broadcast_message

  def set_receiver
    self.receiver = if self.sender_id.eql?(conversation.borrower_id)
      conversation.lender
    else
      conversation.borrower
    end
  end

  def broadcast_message
    conversation_id = conversation.id
    ActionCable.server.broadcast "conversation_#{conversation_id}",
                                 object: { content: content,
                                           sender_type: sender_type,
                                           sender_id: sender_id,
                                           sender_name: sender_name,
                                           conversation_id: conversation_id,
                                           created_at: created_at.strftime("%Y-%m-%d %H:%M:%S %z")
                                 }
    notify_receiver
  end

  def sender_name
    sender.full_name
  end

  def notify_receiver
    Notification.create(
        content: "#{sender_name} sent a new message",
        payload: {
            title: 'new message',
            subject: "#{sender_name} sent a new message"
        },
        recipient: receiver
    )
  end
end
