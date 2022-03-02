require 'rails_helper'

RSpec.describe Book do
  describe 'create a new book' do
    context 'when owner is verified' do
      let(:book) { build :book, owner: build(:verified_user) }

      it { expect(book.approved).to be_truthy }
    end

    context 'when owner is not verified' do
      let(:book) { build :book }

      it { expect(book.approved).to be_falsey }
    end
  end
end
