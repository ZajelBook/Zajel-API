# frozen_string_literal: true

class Notification < ApplicationRecord
  belongs_to :recipient, polymorphic: true

  scope :unread, -> { where(read: false) }

  after_create_commit :send_notification, if: -> { Rails.env.production? }

  def send_notification
    app = Rpush::Gcm::App.find_by(name: 'android_app')

    notification = Rpush::Gcm::Notification.new
    notification.app = app
    notification.registration_ids = recipient.fcm_token
    notification.data = payload
    notification.notification = {
      body: payload['subject'],
      title: payload['title']
    }
    notification.save!
  end
end
