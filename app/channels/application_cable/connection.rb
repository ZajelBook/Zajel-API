module ApplicationCable
  class Connection < ActionCable::Connection::Base
    include ActionController::HttpAuthentication::Basic::ControllerMethods
    include ActionController::HttpAuthentication::Token::ControllerMethods
    identified_by :current_user

    def connect
      client = request.params["client"]
      uid = request.params["uid"]
      access_token = request.params["access-token"]

      self.current_user = find_verified_user(access_token, uid, client)
    end

    private
    def find_verified_user(token, uid, client_id)
      user = User.find_by(email: uid)
      if user && user.valid_token?(token, client_id)
        user
      else
        reject_unauthorized_connection
      end
    end

  end
end
