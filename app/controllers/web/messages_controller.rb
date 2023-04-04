module Web
  class MessagesController < ApplicationController
    before_action :authenticate_user!

    def index
      @conversation = Conversation.find(params[:conversation_id])
      @book_activity = BookActivity.find_by(conversation_id: params[:conversation_id])
      @messages = Message.includes(:sender).where(conversation_id: params[:conversation_id]).order(created_at: :desc)
      @pagy, @messages = pagy(@messages, items: params[:items])
      @messages = @messages.reverse
    end

    def create
      @message = current_user.sent_messages.new(message_params.merge(conversation_id: params[:conversation_id]))
      if @message.save
        respond_to do |format|
          format.turbo_stream
        end
      else
        @error_message = @message.errors
        render 'shared/errors', status: :unprocessable_entity
      end
    end

    private
    def message_params
      params.require(:message).permit(:content, :conversation_id)
    end
  end
end