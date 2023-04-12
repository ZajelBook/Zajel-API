require 'rails_helper'

describe 'static_pages', type: :feature do
  describe 'GET #terms' do
    it 'is expected to render the home template' do
      visit terms_path
      expect(page).to have_current_path terms_path
      expect(page).to have_content 'Please read these Terms and Conditions'
    end
  end

  describe 'GET #privacy_policy' do
    it 'is expected to render the help template' do
      visit policy_path
      expect(page).to have_current_path policy_path
      expect(page).to have_content 'Your privacy is important to us'
    end
  end

  describe 'GET #about' do
    it 'is expected to render the about template' do
      visit about_path
      expect(page).to have_current_path about_path
      expect(page).to have_content 'Zajel is a free platform that helps readers around the globe'
    end
  end
end