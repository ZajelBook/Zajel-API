# frozen_string_literal: true

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

  describe 'scopes' do
    describe '.active' do
      let!(:book) { create :book }
      let!(:book1) { create :book, status: :unavailable }
      let!(:book2) { create :book, status: :borrowed }
      let!(:book3) { create :book, approved: false }
      let!(:book4) { create :book, is_mock: true }
      let!(:book5) { create :book, status: :available, approved: true, is_mock: false }

      it { expect(described_class.active).to eq [book5] }
      it { expect(described_class.active).not_to include(book) }
      it { expect(described_class.active).not_to include(book1) }
      it { expect(described_class.active).not_to include(book2) }
      it { expect(described_class.active).not_to include(book3) }
      it { expect(described_class.active).not_to include(book4) }
    end

    describe '.approved' do
      let!(:book) { create :approved_book }
      let!(:book1) { create :book, approved: false }

      it { expect(described_class.approved).to eq [book] }
      it { expect(described_class.approved).not_to include(book1) }
    end

    describe '.mocks' do
      let!(:book) { create :book }
      let!(:book1) { create :book, is_mock: true }

      it { expect(described_class.mocks).to eq [book1] }
      it { expect(described_class.mocks).not_to include(book) }
    end

    describe '.waiting_approval' do
      let!(:book) { create :approved_book }
      let!(:book1) { create :book, approved: false }

      it { expect(described_class.waiting_approval).to eq [book1] }
      it { expect(described_class.waiting_approval).not_to include(book) }
    end

    describe '.nearby' do
      let!(:user) { create :user, latitude: '50.44351305245807', longitude: '7.908421175548597' }
      let!(:user1) { create :user, latitude: '50.14170587960567', longitude: '8.689173079901025' }
      let!(:user2) { create :user, latitude: '48.748945343432936', longitude: '9.216418849226102' }
      let!(:book) { create :approved_book, owner: user }
      let!(:book1) { create :approved_book, owner: user1 }
      let!(:book2) { create :approved_book, owner: user2 }

      it { expect(described_class.nearby(user.coordinates, user.id)).to eq [book1, book2] }
    end
  end

  describe 'methods' do
    describe '#requested_by?' do
      let(:user) { create :user }
      let(:user2) { create :user }
      let(:book) { create :approved_book, owner: create(:user) }
      let!(:book_activity) { create :book_activity, book: book, borrower: user, status: :pending }

      it { expect(book).to be_requested_by(user.id) }
      it { expect(book).not_to be_requested_by(user2.id) }
    end

    describe '#skip_verification' do
      let(:user) { create :verified_user }
      let(:book) { create :book, owner: user }

      it { expect(book.approved).to be_truthy }
    end

    describe '.search' do
      let(:user) { create :user }
      let!(:book) { create :approved_book, title: 'test', owner: user }
      let!(:book1) { create :approved_book, title: 'test1', owner: user }
      let!(:book2) { create :approved_book, title: 'test2', owner: user }

      it { expect(described_class.search(user.id, 'test')).to eq [book, book1, book2] }
      it { expect(described_class.search(user.id, 'test1')).to eq [book1] }
    end

    describe 'display language' do
      let!(:english) { create :language, attributes: { name: 'انكليزي', locale: 'ar' } }
      let!(:book) { create :approved_book, language: 'English' }

      it { expect(book.display_language).to eq 'English' }

      it do
        I18n.with_locale(:ar) { expect(book.display_language).to eq 'انكليزي' }
      end
    end
  end
end
