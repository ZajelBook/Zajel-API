# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery unless: -> { request.format.json? }

  include PreRequest

  before_action :configure_permitted_parameters, if: :devise_controller?, except: :callback

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[first_name
                                                         last_name
                                                         birth_date
                                                         phone_number
                                                         fcm_token])
  end
end
