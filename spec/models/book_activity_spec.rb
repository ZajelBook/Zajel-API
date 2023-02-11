require 'rails_helper'

RSpec.describe BookActivity do
  include ActiveJob::TestHelper

  before do
    allow_any_instance_of(Notification).to receive(:send_notification).and_return(true)
    allow_any_instance_of(User).to receive(:send_confirmation_code).and_return(true)
    clear_enqueued_jobs
  end

  describe 'create book activity' do
    let(:book_activity) { build_stubbed :book_activity }

    it { expect(book_activity).to be_valid }

    it do
      book_activity.validate
      expect(book_activity.lender).not_to be_nil
    end
  end

  describe 'Updating book activity while book is available' do
    let(:borrower) { create :verified_user }
    let(:book) { create :approved_book }
    let(:book_activity) { create :book_activity, borrower: borrower, book: book }

    context 'when lender accept the request' do
      before { book_activity.accepted! }

      it { expect(book_activity).to be_accepted  }
      it { expect(book_activity.conversation).to be_present }
      it { expect(book_activity.book).to be_borrowed }
      it { expect(ActiveJob::Base.queue_adapter.enqueued_jobs.size).to eq(2) }
    end

    context 'when lender reject the request' do
      before { book_activity.rejected! }

      it { expect(book_activity).to be_rejected }
      it { expect(book_activity.conversation).not_to be_present }
      it { expect(ActiveJob::Base.queue_adapter.enqueued_jobs.size).to eq(2) }
    end
  end

  describe 'Updating book activity while book is borrowed' do
    let(:borrower) { create :verified_user }
    let(:book) { create :approved_book }
    let(:book_activity) { create :book_activity, borrower: borrower, book: book }

    context 'when lender accept the request' do
      before do
        book.borrowed!
        book_activity.update(status: :accepted)
        book_activity.reload
      end

      it { expect(book_activity).to be_pending }
      it { expect(book_activity.conversation).not_to be_present }
      it { expect(ActiveJob::Base.queue_adapter.enqueued_jobs.size).to eq(1) }
    end

    context 'when lender reject the request' do
      before { book_activity.rejected! }

      it { expect(book_activity).to be_rejected }
      it { expect(book_activity.conversation).not_to be_present }
      it { expect(ActiveJob::Base.queue_adapter.enqueued_jobs.size).to eq(2) }
    end
  end
end
