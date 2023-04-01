class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def notify_admins(message)
    return if Rails.env.local? || Rails.env.development?

    SendTelegramNotificationJob.perform_later(message)
  end
end
