class Notification < ApplicationRecord
  belongs_to :recipient, polymorphic: true

  scope :unread, -> {where(read: false)}

  after_create_commit :send_notification

  def send_notification
    app = Rpush::Gcm::App.find_by_name('android_app')

    notification = Rpush::Gcm::Notification.new
    notification.app = app
    notification.registration_ids = recipient.fcm_token
    notification.data = self.payload
    notification.notification = {
        body: self.payload.dig('subject'),
        title: self.payload.dig('title')
    }
    notification.save!
  end
end
