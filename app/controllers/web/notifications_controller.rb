module Web
  class NotificationsController < ApplicationController
    before_action :authenticate_user!

    def index
      @notifications = current_user.notifications.order(created_at: :desc)
      @pagy, @notifications = pagy(@notifications, items: params[:per_page])
    end

    def unread
      @notifications_count = current_user.notifications.unread.count
    end

    def read
      current_user.notifications.unread.update_all(read: true)

      head :ok
    end
  end
end