# frozen_string_literal: true

module ConversationsHelper
  def conversation_header(book_activity)
    chat_with = if book_activity.borrower_id == current_user.id
                  book_activity.lender.full_name
                else
                  book_activity.borrower.full_name
                end

    tag.div class: 'user_info' do
      tag.span do
        "Chat with #{chat_with}"
      end
    end
  end
end
