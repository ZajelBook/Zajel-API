class SendTelegramNotificationJob
  include Sidekiq::Worker

  def perform(message)
    TelegramNotifier.send_notification(message)
  end
end
