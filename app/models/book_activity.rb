class BookActivity < ApplicationRecord
  belongs_to :book
  belongs_to :borrower, polymorphic: true
  belongs_to :lender, polymorphic: true
  belongs_to :conversation, optional: true

  enum status: [:pending, :accepted, :rejected]

  before_validation :set_lender

  validate :borrower_and_lender
  after_create :notify_lender
  after_update :create_conversation, if: :accepted?
  after_update :notify_borrower, if: :saved_change_to_status?
  after_update :update_book_status, if: :accepted?

  after_create -> { notify_admins("a new borrow request has been sent") }

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
    Notification.create(
        content: "#{borrower.full_name} wants to borrow #{book.title}",
        payload: {
            title: 'You have got a new borrow request',
            subject: "#{borrower.full_name} wants to borrow #{book.title}",
            type: 'borrow_request'
        },
        recipient: lender
    )
  end

  def notify_borrower
    content, title, type = if accepted?
                       [
                           "#{lender.full_name} accepted your request to borrow (#{book.title})",
                           'request accepted',
                           'request_accepted'
                       ]
                     elsif rejected?
                        [
                            "#{lender.full_name} rejected your request to borrow (#{book.title})",
                            'request rejected',
                            'request_rejected'
                        ]
                     else
                       return nil
    end
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

  def borrower_and_lender
    borrower_id == lender_id ? errors.add("invalid", "can't borrow your own book") : true
  end
end
