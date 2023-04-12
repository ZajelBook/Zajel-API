# frozen_string_literal: true

class Conversation < ApplicationRecord
  has_many :messages
  belongs_to :borrower, polymorphic: true
  belongs_to :lender, polymorphic: true

  has_many :book_activities
end
