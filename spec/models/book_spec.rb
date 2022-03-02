require 'rails_helper'

RSpec.describe Book do
  before { allow_any_instance_of(User).to receive(:send_confirmation_code).and_return(true) }

  describe 'create a new book' do
    context 'when owner is verified' do
      let(:book) { create :book, owner: build(:verified_user) }

      it { expect(book.approved).to be_truthy }
    end

    context 'when owner is not verified' do
      let(:book) { create :book }

      it { expect(book.approved).to be_falsey }
    end
  end
end
