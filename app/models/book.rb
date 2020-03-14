class Book < ApplicationRecord
  has_many :book_activities
  belongs_to :user
  belongs_to :genre

  enum status: [:available, :unavailable, :borrowed]
end
