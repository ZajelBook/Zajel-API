class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session, unless: -> { request.format.json? }

  around_action :switch_locale

  def switch_locale(&action)
    current_user.update_columns(locale: request.headers['locale']) if current_user && current_user.locale != request.headers['locale']
    locale = request.headers['locale'] || I18n.default_locale
    I18n.with_locale(locale, &action)
  end
end
