module Admins
  class GenresController < ApplicationController
    def index
      @genres = Genre.all.order(name: :asc)
      @pagy, @genres = pagy(@genres, items: params[:per_page])
    end

    def new
      @genre = Genre.new
    end

    def create
      genre = Genre.new(genre_params)
      if genre.save
        redirect_to admins_genres_path
      else
        render :new
      end
    end

    def edit
      @genre = Genre.find(params[:id])
    end

    def update
      genre = Genre.find(params[:id])
      if genre.update(genre_params)
        redirect_to admins_genres_path
      else
        render :edit
      end
    end

    private
    def genre_params
      params.require(:genre).permit(:name, translations_attributes: [
        :id, :_destroy,
        :locale,
        :name,
      ])
    end
  end
end
