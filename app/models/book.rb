class Book < ApplicationRecord
  extend FriendlyId
  include PgSearch::Model

  pg_search_scope :search_by_title,
                  against: :title,
                  using: {
                      tsearch: { prefix: true }
                  }

  friendly_id :title, use: :slugged

  has_one_attached :image

  has_many :book_activities
  belongs_to :owner, polymorphic: true
  belongs_to :genre

  enum status: [:available, :unavailable, :borrowed]

  scope :approved, -> { where(approved: true) }

  scope :active, -> { available.approved.where(is_mock: false) }

  scope :waiting_approval, -> { where(approved: false) }

  scope :mocks, -> { where(is_mock: true) }

  scope :nearby, -> (coordinates, current_user_id) do
    joins('INNER JOIN users ON books.owner_id = users.id AND books.owner_type = \'User\' ')
      .merge(User.where.not(id: current_user_id).nearby(coordinates))
      .active
      .select('books.*, books.id AS id')
  end

  before_create :skip_verification, if: -> { owner.verified? }

  after_create_commit -> { notify_admins("We just got a new book: #{self.title} added by #{self.owner.full_name}") }

  def requested_by?(user_id)
    book_activities.find do |book_activity|
      book_activity.borrower_type.eql?('User') &&
        book_activity.borrower_id.eql?(user_id) &&
        book_activity.pending? &&
        self.available?
    end
  end

  def skip_verification
    self.approved = true
  end

  def self.search(user_id, query)
    user = User.find(user_id)

    return user.books if query.blank?

    search_by_title(query).where(owner_id: user_id)
  end

  def display_language
    translation = Language::Translation.find_by(name: self.language)
    language = Language.find_by(id: translation.language_id)
    language&.name || self.language
  end
end
