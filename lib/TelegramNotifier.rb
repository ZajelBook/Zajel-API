require 'telegram/bot'

class TelegramNotifier
  def self.send_notification(message)
    Telegram::Bot::Client.run(ENV['TELEGRAM_BOT_TOKEN']) do |bot|
      bot.api.send_message(chat_id: ENV['TELEGRAM_CHANNEL_ID'], text: message)
    end
  end
end
