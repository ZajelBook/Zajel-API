class Web::ApplicationController < ActionController::Base
  include Pagy::Backend

  before_action :get_request
  before_action :set_cookies
  before_action :turbo_frame_request_variant
  before_action :set_location

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

  def set_location
    return redirect_to root_path(redirect: request.referer || request.url) if cookies['latitude'].nil? && cookies['longitude'].nil? && params[:redirect].nil?
    return unless current_user

    current_user.update(latitude: cookies['latitude'], longitude: cookies['longitude'])
  end
end
