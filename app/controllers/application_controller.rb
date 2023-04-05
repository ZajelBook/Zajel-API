class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session, unless: -> { request.format.json? }

  before_action :configure_permitted_parameters, if: :devise_controller?, except: :callback
  around_action :switch_locale

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name,
                                                       :last_name,
                                                       :birth_date,
                                                       :phone_number,
                                                       :fcm_token])
  end

  def switch_locale(&action)
    current_user.update_columns(locale: request.headers['locale']) if current_user && current_user.locale != request.headers['locale']
    locale = request.headers['locale'] || I18n.default_locale
    I18n.with_locale(locale, &action)
  end
end
