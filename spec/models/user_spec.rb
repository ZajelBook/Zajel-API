# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User do
  before { allow_any_instance_of(described_class).to receive(:send_confirmation_code).and_return(true) }

  describe 'create a new user' do
    let(:user) { create :user }

    it { expect(user.confirmation_token).not_to be_nil }
    it { expect(user.confirmed_at).to be_nil }
    it { expect(user.full_name).to eq 'Test User' }
  end

  describe 'methods' do
    let(:user) { create :user }

    it { expect(user.coordinates).to eq [50.110924, 8.682127] }
    it { expect(user.full_name).to eq 'Test User' }
    it { expect(user.set_confirmation_code).to be_present }
  end
end
