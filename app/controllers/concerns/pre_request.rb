module PreRequest
  extend ActiveSupport::Concern

  included do
    around_action :switch_locale, unless: :status_controller?
    before_action :get_request, unless: :status_controller?

    def switch_locale(&action)
      current_user.update_columns(locale: request.headers['locale']) if current_user && current_user.locale != request.headers['locale']

      locale = if I18n.available_locales.include?(params[:locale]&.to_sym)
                 params[:locale]
               else
                 request.headers['locale'] || I18n.default_locale
               end

      I18n.with_locale(locale, &action)
    end

    def get_request
      return if Rails.env.development?

      Request.create(user_email: current_user&.email,
                     remote_ip: request.remote_ip,
                     controller_class: request.controller_class,
                     original_path: request.original_fullpath,
                     method: request.method)
    end

    private

    def status_controller?
      is_a?(::Api::StatusController)
    end
  end
end