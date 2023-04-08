module Api
  class ApplicationController < ActionController::API
    include DeviseTokenAuth::Concerns::SetUserByToken
    rescue_from Pagy::OverflowError, with: :render_pagination_error
    include Pagy::Backend
    include PreRequest

    before_action :configure_permitted_parameters, if: :devise_controller?, except: :callback
    after_action { pagy_headers_merge(@pagy) if @pagy }

    protected

    def render_pagination_error
      render json: {errors: []}, status: 200
    end

    def check_user_confirmation_status
      # if current_user && current_user.confirmed_at.nil?
      #   render json: { error: { message: 'user not confirmed' } }, status: :forbidden
      # end
    end
  end
end