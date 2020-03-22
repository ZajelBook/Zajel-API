class Conversation < ApplicationRecord
  has_many :messages
  belongs_to :borrower, polymorphic: true
  belongs_to :lender, polymorphic: true
end
