class Book < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged

  has_one_attached :image
  attr_accessor :distance

  has_many :book_activities
  belongs_to :owner, polymorphic: true
  belongs_to :genre

  enum status: [:available, :unavailable, :borrowed]

  scope :approved, -> { where(approved: true) }

  scope :active, -> (owner_ids) { available.approved.where(owner_id: owner_ids) }

  scope :waiting_approval, -> { where(approved: false) }

  scope :mocks, -> { where(is_mock: true) }

  def requested_by?(user_id)
    book_activities.select do |book_activity|
      book_activity.borrower_type.eql?('User') && book_activity.borrower_id.eql?(user_id) && book_activity.pending? && self.available?
    end.any?
  end
end
