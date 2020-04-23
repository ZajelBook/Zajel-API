module Api
  class BooksController < ApplicationController
    before_action :authenticate_user!, except: [:index, :show]
    before_action :set_book, only: [:show, :update]
    skip_before_action :check_user_confirmation_status, only: [:index, :show]

    def index
      @nearby_users = User.near(set_coordinates, ENV['SEARCH_RADIUS'], units: :km)

      @books = Book.active(set_user_ids).includes(:owner, :book_activities, :genre, image_attachment: :blob).order(created_at: :desc)
      @nearby_users.map {|user| [user.id, user.distance]}.flatten!
      @pagy, @books = pagy(@books, items: params[:per_page])
    end

    def show
      @distance = @book.owner.distance_to(set_coordinates, :km)
    end

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
      params.permit(:title, :author, :description, :page_count, :language, :image, :published_at, :genre_id, :status)
    end

    def set_book
      if params[:id].present?
        @book = Book.find(params[:id])
      elsif params[:friendly_id].present?
        @book = Book.friendly.find(params[:friendly_id])
      end
    end

    def set_coordinates
      user_signed_in? ? [current_user.latitude, current_user.longitude] : [params[:latitude], params[:longitude]]
    end

    def set_user_ids
      if user_signed_in?
        nearby_user_ids = @nearby_users.load.ids
        nearby_user_ids.delete(current_user.id)
        nearby_user_ids
      else
        @nearby_users.load.ids
      end
    end
  end
end
