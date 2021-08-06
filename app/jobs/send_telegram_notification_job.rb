class SendTelegramNotificationJob
  def perform(message)
    TelegramNotifier.send_notification(message)
  end
end
