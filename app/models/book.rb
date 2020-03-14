class Book < ApplicationRecord
  has_one_attached :image

  has_many :book_activities
  belongs_to :user
  belongs_to :genre

  enum status: [:available, :unavailable, :borrowed]

  scope :approved, -> { where(approved: true) }

  scope :active, -> { available.approved }
end
