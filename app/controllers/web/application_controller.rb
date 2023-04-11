class Web::ApplicationController < ActionController::Base
  include Pagy::Backend
  include PreRequest

  before_action :turbo_frame_request_variant
  before_action :set_location, unless: :static_pages_controller?

  protected
  def turbo_frame_request_variant
    request.variant = :turbo_frame if turbo_frame_request?
  end

  def set_location
    return redirect_to root_path(redirect: request.referer || request.url) if cookies['latitude'].nil? && cookies['longitude'].nil? && params[:redirect].nil?
    return unless current_user

    current_user.update(latitude: cookies['latitude'], longitude: cookies['longitude'])
  end

  private

  def static_pages_controller?
    is_a?(Web::StaticPagesController)
  end
end
