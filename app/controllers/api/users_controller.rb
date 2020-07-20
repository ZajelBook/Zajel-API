module Api
  class UsersController < ApplicationController
    before_action :authenticate_user!
    skip_before_action :check_user_confirmation_status

    def show
      @user = current_user
    end

    def update
      if current_user.update(user_params)
        render json: { status: 'success' }
      else
        render json: { error: current_user.errors }, status: :unprocessable_entity
      end
    end

    def confirm
      if current_user.confirmation_token == params[:confirmation_code]
        if current_user.update(confirmed_at: DateTime.now)
          render json: { status: 'success' }
        else
          render json: { error: current_user.errors }, status: :unprocessable_entity
        end
      end
    end

    def re_send
      if current_user.send_confirmation_code
        render json: { status: 'success' }
      else
        render json: { error: 'cannot send confirmation code' }, status: :unprocessable_entity
      end
    end

    def user_params
      params.permit(:first_name, :last_name, :birth_date, :phone_number, :latitude, :longitude, :fcm_token)
    end
  end
end