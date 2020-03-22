class ConversationChannel < ApplicationCable::Channel
  def subscribed
    stream_from "conversation_#{params[:id]}"
  end
end