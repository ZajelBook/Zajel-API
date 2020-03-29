class Book < ApplicationRecord
  has_one_attached :image

  has_many :book_activities
  belongs_to :owner, polymorphic: true
  belongs_to :genre

  enum status: [:available, :unavailable, :borrowed]

  scope :approved, -> { where(approved: true) }

  scope :active, -> { available.approved }

  def requested_by?(user_id)
    book_activities.select do |book_activity|
      book_activity.borrower_type.eql?('User') && book_activity.borrower_id.eql?(user_id) && book_activity.pending? && self.available?
    end.any?
  end
end
