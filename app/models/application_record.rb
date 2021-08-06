class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def notify_admins(message)
    SendTelegramNotificationJob.perform_later(message)
  end
end
