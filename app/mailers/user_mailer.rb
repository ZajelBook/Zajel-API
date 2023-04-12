# frozen_string_literal: true

class UserMailer < Devise::Mailer
  def reset_password_instructions(record, token, opts = {})
    super
  end
end
