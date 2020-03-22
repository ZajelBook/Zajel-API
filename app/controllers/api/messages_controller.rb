module Api
  class MessagesController < ApplicationController
    before_action :authenticate_user!

    def index
      @messages = Message.where(conversation_id: params[:conversation_id])
    end

    def create
      @message = current_user.sent_messages.new(message_params.merge(conversation_id: params[:conversation_id]))
      if @message.save
        render json: {status: 'message sent'}
      else
        @error_message = @message.errors
        render 'shared/errors', status: :unprocessable_entity
      end
    end

    private
    def message_params
      params.permit(:content, :conversation_id)
    end
  end
end