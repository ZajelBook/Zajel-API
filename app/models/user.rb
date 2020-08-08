# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  include DeviseTokenAuth::Concerns::User
  include SendGrid

  reverse_geocoded_by :latitude, :longitude

  has_many :books, as: :owner
  has_many :borrow_requests, as: :borrower, class_name: 'BookActivity'
  has_many :lend_requests, as: :lender, class_name: 'BookActivity'

  has_many :borrow_conversations, as: :borrower, class_name: 'Conversation'
  has_many :lend_conversations, as: :lender, class_name: 'Conversation'

  has_many :sent_messages, as: :sender, class_name: 'Message'
  has_many :received_messages, as: :receiver, class_name: 'Message'

  has_many :notifications, as: :recipient

  before_create :set_confirmation_code
  after_create -> { notify_admins("We just got a new user: #{self.full_name}") }
  after_create_commit :send_confirmation_code

  def full_name
    [first_name, last_name].join(' ')
  end

  def set_confirmation_code
    self.confirmation_token = rand(3000..9000)
  end

  def send_confirmation_code
    from = Email.new(email: 'info@zajelbook.com')
    to = Email.new(email: self.email)
    subject = 'Zajel confirmation code'
    content = Content.new(type: 'text/plain', value: 'Your confirmation code is: ' + self.confirmation_token)
    mail = Mail.new(from, subject, to, content)

    sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])

    sg.client.mail._('send').post(request_body: mail.to_json)
  end
end
