# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  include DeviseTokenAuth::Concerns::User

  reverse_geocoded_by :latitude, :longitude
  kredis_boolean :online
  has_many :books, as: :owner
  has_many :borrow_requests, as: :borrower, class_name: 'BookActivity'
  has_many :lend_requests, as: :lender, class_name: 'BookActivity'

  has_many :borrow_conversations, as: :borrower, class_name: 'Conversation'
  has_many :lend_conversations, as: :lender, class_name: 'Conversation'

  has_many :sent_messages, as: :sender, class_name: 'Message'
  has_many :received_messages, as: :receiver, class_name: 'Message'

  has_many :notifications, as: :recipient

  before_create :set_confirmation_code
  after_create -> { notify_admins("We just got a new user: #{full_name}") }
  after_create_commit :send_confirmation_code, if: -> { Rails.env.production? }

  scope :nearby, ->(coordinates) { near(coordinates, ENV['SEARCH_RADIUS'].to_i, units: :km) }

  def full_name
    [first_name, last_name].join(' ')
  end

  def coordinates
    [latitude, longitude]
  end

  def set_confirmation_code
    self.confirmation_token = rand(3000..9000)
  end

  def send_confirmation_code
    SibApiV3Sdk.configure do |config|
      config.api_key['api-key'] = ENV['SENDINBLUE_API_KEY']
    end

    api_instance = SibApiV3Sdk::TransactionalEmailsApi.new

    send_smtp_email = SibApiV3Sdk::SendSmtpEmail.new(
      sender: { email: ENV['SENDER_EMAIL'] },
      to: [{ email: email }],
      subject: 'Zajel confirmation code',
      textContent: "Your Zajel confirmation code is: #{confirmation_token}"
    )

    api_instance.send_transac_email(send_smtp_email)
  end
end
