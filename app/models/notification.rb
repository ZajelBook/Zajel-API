class Notification < ApplicationRecord
  belongs_to :recipient, polymorphic: true

  after_create :send_notification

  def send_notification
    app = Rpush::Gcm::App.find_by_name('android_app')

    notification = Rpush::Gcm::Notification.new
    notification.app = app
    notification.registration_ids = recipient.fcm_token
    notification.data = self.payload
    notification.save!
  end
end
