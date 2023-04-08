class Web::ApplicationController < ActionController::Base
  include Pagy::Backend
  include PreRequest

  before_action :set_cookies
  before_action :turbo_frame_request_variant
  before_action :set_location

  protected
  def turbo_frame_request_variant
    request.variant = :turbo_frame if turbo_frame_request?
  end

  def set_cookies
    cookies[:user_id] = self.current_user.id if self.current_user && cookies[:user_id].blank?
  end

  def set_location
    return redirect_to root_path(redirect: request.referer || request.url) if cookies['latitude'].nil? && cookies['longitude'].nil? && params[:redirect].nil?
    return unless current_user

    current_user.update(latitude: cookies['latitude'], longitude: cookies['longitude'])
  end
end
