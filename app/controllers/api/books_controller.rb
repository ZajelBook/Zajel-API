module Api
  class BooksController < ApplicationController
    before_action :authenticate_user!
    before_action :set_book, only: [:show, :update]
    def index
      @books = Book.active.includes(:book_activities, :genre, image_attachment: :blob).order(updated_at: :desc)
      @pagy, @books = pagy(@books, items: params[:per_page])
    end

    def show; end

    def create
      @book = @current_user.books.new(book_params)
      if @book.save
        render 'show'
      else
        @error_message = @book.errors
        render 'shared/errors', status: :unprocessable_entity
      end
    end

    def update
      if @book.update(book_params)
        render 'show'
      else
        @error_message = @book.errors
        render 'shared/errors', status: :unprocessable_entity
      end
    end

    private
    def book_params
      params.permit(:title, :author, :description, :page_count, :language, :image, :published_at, :genre_id)
    end

    def set_book
      @book = Book.find(params[:id])
    end
  end
end
