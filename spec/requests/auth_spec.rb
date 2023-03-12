require 'rails_helper'

RSpec.describe 'Auth', type: :request do
  describe 'Sign up' do
    context 'with valid parameters' do
      let(:users_count) { User.count }
      let!(:params) { {
        email: "email@test.com",
        password: "12345678",
        password_confirmation: "12345678",
        first_name: "test",
        last_name: "test",
        birth_date: "12-12-2013",
        phone_number: "0105246241",
        fcm_token: "sdfgdsfgdsgfgdgsdgdfg"
      } }

      before do
        User.destroy_all

        post '/api/auth', params: params
      end

      it { expect(users_count).to eq(1) }
      it { expect(JSON.parse(response.body)['data']['email']).to eq(params[:email]) }
    end

    context 'with invalid parameters' do
      let(:users_count) { User.count }
      let!(:params) { {
        email: "email@test.com",
        password: "12345"
      } }

      before do
        User.destroy_all

        post '/api/auth', params: params
      end

      it { expect(users_count).to eq(0) }
      it { expect(JSON.parse(response.body)['errors']['password']).to be_present }
    end
  end

  describe 'Sign in' do
    context 'with valid parameters' do
      let!(:user) { create(:user, email: 'email@test.com')}
      let!(:params) { {
        email: "email@test.com",
        password: "12345678",
      } }

      before do
        post '/api/auth/sign_in', params: params
      end

      it { expect(response.code).to eq('200') }
    end

    context 'with invalid parameters' do
      let!(:user) { create(:user, email: 'email@test.com')}
      let!(:params) { {
        email: "email@test.com",
        password: "87654321",
      } }

      before do
        post '/api/auth/sign_in', params: params
      end

      it { expect(response.code).to eq('401') }
      it { expect(JSON.parse(response.body)['errors'].first).to eq('Invalid login credentials. Please try again.') }
    end
  end
end