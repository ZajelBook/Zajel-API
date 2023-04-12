# frozen_string_literal: true

class SendTelegramNotificationJob < ApplicationJob
  def perform(message)
    TelegramNotifier.send_notification(message)
  end
end
