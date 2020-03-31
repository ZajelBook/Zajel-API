class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken
  rescue_from Pagy::OverflowError, with: :render_pagination_error
  include Pagy::Backend

  before_action :configure_permitted_parameters, if: :devise_controller?, except: :callback
  after_action { pagy_headers_merge(@pagy) if @pagy }

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name,
                                                       :last_name,
                                                       :birth_date,
                                                       :phone_number,
                                                       :fcm_token])
  end

  def render_pagination_error
    render json: {errors: []}, status: 200
  end
end
