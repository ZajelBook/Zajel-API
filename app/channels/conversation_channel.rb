class ConversationChannel < ApplicationCable::Channel
  def subscribed
    stream_from "conversation_#{params[:id]}"
    current_user.update(online: true)
  end

  def unsubscribed
    current_user.update(online: false)
  end
end