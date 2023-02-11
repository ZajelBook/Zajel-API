module Api
  module Admin
    class GenresController < ApplicationController
      before_action :authenticate_admin!

      def index
        @genres = Genre.all.order(name: :asc)
      end

      def create
        genre = Genre.new(genre_params)
        if genre.save
          render json: { status: 'success' }
        else
          @error_message = genre.errors
          render 'shared/errors', status: :unprocessable_entity
        end
      end

      def update
        genre = Genre.find(params[:id])
        if genre.update(genre_params)
          render json: { status: 'success' }
        else
          @error_message = genre.errors
          render 'shared/errors', status: :unprocessable_entity
        end
      end

      private

      def genre_params
        params.permit(:name)
      end
    end
  end
end
