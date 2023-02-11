namespace :rpush_app do
  desc 'send notification'
  task send_notification: :environment do
    n = Rpush::Gcm::Notification.new
    n.app = Rpush::Gcm::App.find_by_name("android_app")
    n.registration_ids = User.find_by(email: 'dr.rich4444@gmail.com').fcm_token
    n.data = { message: "hi dr.rich!" }
    n.notification = { body: 'test!',
                       title: 'ZajelApp' }
    n.save!
  end
end
