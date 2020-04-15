module Api
  module Admin
    class MetadataController < ApplicationController
      def index
        @users_count = User.count
        @books_count = Book.count
        @requests_count = BookActivity.count
        @conversations_count = Conversation.count
      end
    end
  end
end
