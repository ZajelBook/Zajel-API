# frozen_string_literal: true

module Web
  class ApplicationController < ActionController::Base
    include Pagy::Backend
    include PreRequest

    before_action :turbo_frame_request_variant
    before_action :set_location, if: :books_controller?

    protected

    def turbo_frame_request_variant
      request.variant = :turbo_frame if turbo_frame_request?
    end

    def set_location
      if cookies['latitude'].nil? && cookies['longitude'].nil? && params[:redirect].nil?
        return redirect_to books_path(redirect: request.url)
      end
      return unless current_user

      current_user.update(latitude: cookies['latitude'], longitude: cookies['longitude'])
    end

    private

    def books_controller?
      is_a?(Web::BooksController)
    end
  end
end
