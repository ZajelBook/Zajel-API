# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Language do
  describe 'Add new language' do
    context 'when not providing any locales' do
      let(:language) { create :language }

      it { expect(language.name).to eq 'English' }
      it { expect(language.translations.count).to eq(1) }
      it { expect(language.translations.pluck(:locale)).to match_array(%w[en]) }
    end

    context 'when providing locales' do
      let(:language) { create :language, attributes: { name: 'انكليزي', locale: 'ar' } }

      it { expect(language.translations.count).to eq(2) }
      it { expect(language.translations.pluck(:locale)).to match_array(%w[ar en]) }
    end
  end

  describe 'accessing a language' do
    let(:language) { create :language, attributes: { name: 'انكليزي', locale: 'ar' } }

    context 'when locale = en' do
      before { I18n.locale = :en }

      it { expect(language.name).to eq('English') }
    end

    context 'when locale = ar' do
      before { I18n.locale = :ar }

      it { expect(language.name).to eq('انكليزي') }
    end
  end
end
