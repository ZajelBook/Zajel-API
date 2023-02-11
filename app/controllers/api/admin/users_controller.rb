module Api
  module Admin
    class UsersController < ApplicationController
      before_action :authenticate_admin!

      def index
        @users = User.all.order(created_at: :desc)
        @pagy, @users = pagy(@users, items: params[:per_page])
      end

      def show
        @user = User.find(params[:id])
        @books = @user.books.includes(image_attachment: :blob).order(created_at: :desc)
        @borrow_requests = @user.borrow_requests.includes(book: [image_attachment: :blob]).order(created_at: :desc)
      end

      def update
        if current_user.update(user_params)
          render json: { status: 'success' }
        else
          render json: { error: current_user.errors }, status: :unprocessable_entity
        end
      end

      def user_params
        params.permit(:first_name, :last_name, :birth_date, :phone_number, :latitude, :longitude, :fcm_token)
      end
    end
  end
end
