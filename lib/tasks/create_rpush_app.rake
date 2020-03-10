namespace :rpush_app do
  desc 'create rpush app'
  task create: :environment do
    app = Rpush::Gcm::App.new
    app.name = "android_app"
    app.auth_key = Rails.application.credentials.FIREBASE_SERVER_KEY
    app.connections = 1
    app.save!
  end
end
