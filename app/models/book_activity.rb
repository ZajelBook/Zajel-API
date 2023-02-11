class BookActivity < ApplicationRecord
  belongs_to :book
  belongs_to :borrower, polymorphic: true
  belongs_to :lender, polymorphic: true
  belongs_to :conversation, optional: true

  enum status: [:pending, :accepted, :rejected]

  ANDROID_NOTIFICATION_TYPES = { accepted: 'request_accepted',
                                 rejected: 'request_rejected',
                                 pending: 'borrow_request' }

  before_validation :set_lender

  validate :borrower_and_lender
  validate :book_availability, on: :update, if: :accepted?
  after_create :notify_lender
  after_update :notify_borrower, if: -> { saved_change_to_status? && (accepted? || rejected?) }

  with_options if: :accepted? do
    after_update :create_conversation
    after_update :update_book_status
  end

  after_create_commit -> { notify_admins("a new borrow request has been sent") }

  scope :active, -> { where.not(status: :rejected) }

  def set_lender
    self.lender = book.owner
  end

  def update_book_status
    book.borrowed!
  end

  def create_conversation
    conversation = Conversation.find_by(borrower: [borrower, lender], lender: [borrower, lender])
    conversation = Conversation.create(borrower: borrower, lender: lender) if conversation.nil?
    self.update_columns(conversation_id: conversation.id)
  end

  def notify_lender
    BookActivityNotificationJob.set(wait: 1.minute).perform_later(self.id, 'lender_notification')
  end

  def notify_borrower
    BookActivityNotificationJob.set(wait: 1.minute).perform_later(self.id, 'borrower_notification')
  end

  def borrower_and_lender
    borrower_id == lender_id ? errors.add("invalid", "can't borrow your own book") : true
  end

  def book_availability
    errors.add("invalid", "Book is not available") unless book.available?
  end

  private

  def lender_notification
    I18n.with_locale(lender.locale || I18n.default_locale) do
      content, title, type = [
        I18n.t('notifications.book_activities.notify_lender.content',
               borrower_full_name: borrower.full_name,
               book_title: book.title),
        I18n.t('notifications.book_activities.notify_lender.title'),
        ANDROID_NOTIFICATION_TYPES[status.to_sym]
      ]

      Notification.create(
        content: content,
        payload: {
          title: title,
          subject: content,
          type: type,
        },
        recipient: lender
      )
    end
  end

  def borrower_notification
    I18n.with_locale(borrower.locale || I18n.default_locale) do
      content, title, type = [
        I18n.t("notifications.book_activities.notify_borrower.#{status}.content",
               lender_full_name: lender.full_name,
               book_title: book.title),
        I18n.t("notifications.book_activities.notify_borrower.#{status}.title"),
        ANDROID_NOTIFICATION_TYPES[status.to_sym]
      ]

      Notification.create(
        content: content,
        payload: {
          title: title,
          subject: content,
          type: type,
          conversation_id: conversation_id
        },
        recipient: borrower
      )
    end
  end
end
