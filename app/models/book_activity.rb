class BookActivity < ApplicationRecord
  belongs_to :book
  belongs_to :borrower, polymorphic: true
  belongs_to :lender, polymorphic: true

  enum status: [:pending, :accepted, :rejected]

  after_create :notify_lender

  def notify_lender
    Notification.create(
        content: "#{borrower.full_name} wants to borrow #{book.title}",
        payload: {
            title: 'You have got a new borrow request',
            subject: "#{borrower.full_name} wants to borrow #{book.title}"
        },
        recipient: lender
    )
  end
end
