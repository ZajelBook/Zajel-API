module Api
  class ApplicationController < ActionController::API
    include DeviseTokenAuth::Concerns::SetUserByToken
    rescue_from Pagy::OverflowError, with: :render_pagination_error
    include Pagy::Backend

    around_action :switch_locale, unless: :status_controller?

    before_action :configure_permitted_parameters, if: :devise_controller?, except: :callback
    before_action :get_request, unless: :status_controller?
    before_action :check_user_confirmation_status, unless: :devise_controller?
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

    def get_request
      return if Rails.env.development?

      unless request.original_fullpath.include?('api/admin/')
        Request.create(user_email: current_user&.email,
                       remote_ip: request.remote_ip,
                       controller_class: request.controller_class,
                       original_path: request.original_fullpath,
                       method: request.method)
      end
    end

    def status_controller?
      is_a?(::Api::StatusController)
    end
  end
end