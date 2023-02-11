module Api
  class NotificationsController < ApplicationController
    before_action :authenticate_user!
    skip_before_action :check_user_confirmation_status, only: [:unread]

    def index
      @notifications = current_user.notifications.order(created_at: :desc)
      @pagy, @notifications = pagy(@notifications, items: params[:per_page])
    end

    def unread
      @notifications_count = current_user.notifications.unread.count
      render json: { notifications_count: @notifications_count }
    end

    def read
      current_user.notifications.unread.update_all(read: true)
      render json: { message: 'updated' }
    end
  end
end
