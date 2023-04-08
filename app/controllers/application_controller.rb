class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session, unless: -> { request.format.json? }

  before_action :configure_permitted_parameters, if: :devise_controller?, except: :callback

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name,
                                                       :last_name,
                                                       :birth_date,
                                                       :phone_number,
                                                       :fcm_token])
  end

  def after_sign_out_path_for(_scope)
    admins_root_path
  end
end
