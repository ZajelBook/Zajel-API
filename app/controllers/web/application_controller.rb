class Web::ApplicationController < ActionController::Base
  include Pagy::Backend

  around_action :switch_locale

  before_action :configure_permitted_parameters, if: :devise_controller?, except: :callback
  before_action :get_request
  before_action :set_cookies
  before_action :turbo_frame_request_variant

  after_action { pagy_headers_merge(@pagy) if @pagy }

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name,
                                                       :last_name,
                                                       :birth_date,
                                                       :phone_number,
                                                       :fcm_token])
  end


  def turbo_frame_request_variant
    request.variant = :turbo_frame if turbo_frame_request?
  end

  def set_cookies
    cookies[:user_id] = self.current_user.id if self.current_user && cookies[:user_id].blank?
  end

  def switch_locale(&action)
    current_user.update_columns(locale: request.headers['locale']) if current_user && current_user.locale != request.headers['locale']
    locale = request.headers['locale'] || I18n.default_locale
    I18n.with_locale(locale, &action)
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
end
