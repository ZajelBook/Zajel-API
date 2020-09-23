class Book < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged

  has_one_attached :image

  has_many :book_activities
  belongs_to :owner, polymorphic: true
  belongs_to :genre

  enum status: [:available, :unavailable, :borrowed]

  scope :approved, -> { where(approved: true) }

  scope :active, -> (owner_id) { available.approved.where(owner_id: owner_id, is_mock: false) }

  scope :waiting_approval, -> { where(approved: false) }

  scope :mocks, -> { where(is_mock: true) }

  scope :nearby, -> (coordinates, except_user_id) { joins('INNER JOIN users ON books.owner_id = users.id').where(books: {owner_type: 'User'}).merge(User.where.not(id: except_user_id).nearby(coordinates)).active(except_user_id).select('books.*, books.id AS id') }

  before_create :skip_verification, if: Proc.new { owner.verified? }

  after_create -> { notify_admins("We just got a new book: #{self.title} added by #{self.owner.full_name}") }

  def requested_by?(user_id)
    book_activities.select do |book_activity|
      book_activity.borrower_type.eql?('User') && book_activity.borrower_id.eql?(user_id) && book_activity.pending? && self.available?
    end.any?
  end

  def skip_verification
    self.approved = true
  end
end
