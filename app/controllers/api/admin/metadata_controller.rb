module Api
  module Admin
    class MetadataController < ApplicationController
      before_action :authenticate_admin!

      def index
        @users_count = User.count
        @books_count = Book.count
        @requests_count = BookActivity.count
        @conversations_count = Conversation.count

        @request_per_day_count = Request.group("date(created_at)").count
        @request_per_country_count = Request.group(:country).count
      end
    end
  end
end
