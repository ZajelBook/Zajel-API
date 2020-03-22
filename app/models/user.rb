# frozen_string_literal: true

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  include DeviseTokenAuth::Concerns::User

  has_many :books
  has_many :borrow_requests, as: :borrower, class_name: 'BookActivity'
  has_many :lend_requests, as: :lender, class_name: 'BookActivity'

  has_many :borrow_conversations, as: :borrower, class_name: 'Conversation'
  has_many :lend_conversations, as: :lender, class_name: 'Conversation'

  has_many :sent_messages, as: :sender, class_name: 'Message'

  has_many :notifications, as: :recipient

  def full_name
    [first_name, last_name].join(' ')
  end
end
