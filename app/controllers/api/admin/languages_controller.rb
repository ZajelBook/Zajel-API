module Api
  module Admin
    class LanguagesController < ApplicationController
      before_action :authenticate_admin!

      def index
        @languages = Language.all.order(name: :asc)
      end

      def create
        language = Language.new(language_params)
        if language.save
          render json: { status: 'success' }
        else
          @error_message = language.errors
          render 'shared/errors', status: :unprocessable_entity
        end
      end

      def update
        language = Language.find(params[:id])
        if language.update(language_params)
          render json: { status: 'success' }
        else
          @error_message = language.errors
          render 'shared/errors', status: :unprocessable_entity
        end
      end

      private
      def language_params
        params.permit(:name)
      end
    end
  end
end
