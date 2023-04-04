module Web
  class BooksController < ApplicationController
    before_action :authenticate_user!, except: [:index, :show]
    before_action :set_book, only: [:show, :edit, :update]

    def index
      @books = Book.nearby(set_coordinates, current_user.try(:id))
                   .includes(genre: :translations, image_attachment: :blob)

      if @books.empty?
        @books = Book.mocks.includes(:genre, image_attachment: :blob)
        @distance = rand(100)
        @nearby_users = nil
      end

      @pagy, @books = pagy(@books, items: params[:per_page])
    end

    def show
      if @book.is_mock?
        @distance = rand(100)
      else
        @distance = @book.owner.distance_to(set_coordinates, :km)
      end
    end

    def new
      @book = @current_user.books.new
    end

    def create
      @book = @current_user.books.new(book_params)
      if @book.save
        redirect_to book_path(@book.id)
      else
        render :new, status: :unprocessable_entity
      end
    end

    def edit; end

    def update
      if @book.update(book_params)
        redirect_to book_path(@book.id)
      else
        render :edit, status: :unprocessable_entity
      end
    end

    private
    def book_params
      params.require(:book).permit(:title, :author, :description, :page_count, :language, :image, :published_at, :genre_id, :status)
    end

    def set_book
      if params[:id].present?
        @book = Book.find(params[:id])
      elsif params[:friendly_id].present?
        @book = Book.friendly.find(params[:friendly_id])
      end
    end

    def set_coordinates
      [cookies['latitude'], cookies['longitude']]
      # user_signed_in? ? [current_user.latitude, current_user.longitude] : [params[:latitude], params[:longitude]]
    end
  end
end