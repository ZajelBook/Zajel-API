# frozen_string_literal: true

class ConversationChannel < ApplicationCable::Channel
  def subscribed
    stream_from "conversation_#{params[:id]}"

    current_user.online.value = true
  end

  def unsubscribed
    current_user.online.value = false
  end
end
