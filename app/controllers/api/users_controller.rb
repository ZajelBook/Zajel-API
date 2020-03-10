module Api
  class UsersController < ApplicationController
    before_action :authenticate_user!
    def update
      if current_user.update(user_params)
        render json: { status: 'success' }
      else
        render json: { error: current_user.errors }, status: :unprocessable_entity
      end
    end

    def user_params
      params.permit(:first_name, :last_name, :birth_date, :phone_number, :latitude, :longitude)
    end
  end
end