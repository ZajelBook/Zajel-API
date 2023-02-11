module Api
  class MyBooksController < ApplicationController
    before_action :authenticate_user!
    def index
      @my_books = Book.search(current_user.id, params[:query])
                      .includes(:book_activities, :genre, image_attachment: :blob)
                      .order(created_at: :desc)
      @pagy, @my_books = pagy(@my_books, items: params[:per_page])
    end
  end
end
