module Api
  class NotificationsController < ApplicationController
    before_action :authenticate_user!

    def index
      @notifications = current_user.notifications.order(created_at: :desc)
      @pagy, @notifications = pagy(@notifications, items: params[:per_page])
    end
  end
end