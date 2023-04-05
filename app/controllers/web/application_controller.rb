class Web::ApplicationController < ActionController::Base
  include Pagy::Backend

  before_action :get_request
  before_action :set_cookies
  before_action :turbo_frame_request_variant

  after_action { pagy_headers_merge(@pagy) if @pagy }

  protected
  def turbo_frame_request_variant
    request.variant = :turbo_frame if turbo_frame_request?
  end

  def set_cookies
    cookies[:user_id] = self.current_user.id if self.current_user && cookies[:user_id].blank?
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
