class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def notify_admins(message)
    return if Rails.env.test? || Rails.env.development?

    SendTelegramNotificationJob.perform_later(message)
  end
end
