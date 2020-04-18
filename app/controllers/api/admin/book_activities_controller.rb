module Api
  module Admin
    class BookActivitiesController < ApplicationController
      def index
        @book_activities = BookActivity.includes(:borrower, :lender, :book).order(created_at: :desc)
        @pagy, @book_activities = pagy(@book_activities, items: params[:per_page])
      end
    end
  end
end
