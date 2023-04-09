module Web
  class MyBooksController < ApplicationController
    before_action :authenticate_user!
    def index
      @books = Book.search(current_user.id, params[:query])
                      .includes(:book_activities, :genre, image_attachment: :blob)
                      .order(created_at: :desc)

      @pagy, @books = pagy(@books, items: params[:per_page])
    end
  end
end

