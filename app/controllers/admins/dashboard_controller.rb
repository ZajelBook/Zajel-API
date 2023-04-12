# frozen_string_literal: true

module Admins
  class DashboardController < ApplicationController
    def index
      @users_count = User.count
      @books_count = Book.count
      @requests_count = BookActivity.count
      @conversations_count = Conversation.count

      @requests_per_month = Request.group_by_month(:created_at, last: 12).count

      @requests_per_country = Request.group(:country).count.sort_by { |_, v| -v }.first(5)

      @users_locales = User.group(:locale).count

      @users_clients = {}
      users_fcm_tokens_count = User.group(:fcm_token).count
      @users_clients[:mobile] = users_fcm_tokens_count.except(nil).count
      @users_clients[:web] = users_fcm_tokens_count[nil]
    end
  end
end
