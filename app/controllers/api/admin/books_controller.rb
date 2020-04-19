module Api
  module Admin
    class BooksController < ApplicationController
      before_action :authenticate_admin!

      before_action :set_book, only: [:show, :update]

      def index
        scope = Book.approved
        scope = Book.waiting_approval if params[:type].present? && params[:type].eql?('new')
        @books = scope.includes(:owner).order(created_at: :desc)
        @pagy, @books = pagy(@books, items: params[:per_page])
      end

      def show
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
        params.permit(:title, :author, :description, :page_count, :language, :image, :published_at, :genre_id, :approved, :status)
      end

      def set_book
        @book = Book.find(params[:id])
      end

    end
  end
end