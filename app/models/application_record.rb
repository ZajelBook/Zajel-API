class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def notify_admins(message)
    SendTelegramNotificationJob.perform_async(message)
  end
end
