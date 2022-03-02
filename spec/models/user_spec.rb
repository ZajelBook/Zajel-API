require 'rails_helper'

RSpec.describe User do
  before { allow_any_instance_of(User).to receive(:send_confirmation_code).and_return(true) }

  describe 'create a new user' do
    let(:user) { create :user }

    it { expect(user.confirmation_token).not_to be_nil  }
    it { expect(user.confirmed_at).to be_nil  }
    it { expect(user.full_name).to eq 'Test User'  }
  end
end
