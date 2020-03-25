class Message < ApplicationRecord
  belongs_to :conversation
  belongs_to :sender, polymorphic: true

  after_create :broadcast_message

  def broadcast_message
    ActionCable.server.broadcast "conversation_#{conversation.id}",
                                 object: { content: content,
                                           sender_type: sender_type,
                                           sender_id: sender_id,
                                           sender_name: sender_name
                                 }
  end

  def sender_name
    sender.full_name
  end
end
