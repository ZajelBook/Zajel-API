require 'rails_helper'

RSpec.describe Message do
  describe 'Sending a message' do
    let(:borrower) { create :verified_user }
    let(:book) { create :approved_book }
    let(:book_activity) { create :book_activity, borrower: borrower, book: book }
    let(:message) do
      book_activity.accepted!
      conversation = book_activity.conversation

      create :message, conversation: conversation, sender: conversation.borrower
    end

    it { expect(message.receiver).to be_present }
    it { expect(message.content).to eq('Message content goes here') }
  end
end
