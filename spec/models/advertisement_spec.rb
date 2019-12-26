# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Advertisement, type: :model do
  describe '#factory' do
    it 'is valid' do
      expect(build(:advertisement)).to be_valid
    end
  end

  describe '#ad_title valid?' do
    context 'ad_title is nil' do
      let(:advertisement) { build(:advertisement, ad_title: '') }

      it 'validates presence' do
        expect(advertisement).to_not be_valid
      end
    end

    context 'ad_title is too short' do
      let(:advertisement) do
        build(:advertisement,
              ad_title: Faker::String.random(length: 1..4))
      end

      it 'validates presence' do
        expect(advertisement).to_not be_valid
      end
    end

    context 'ad_title is too long' do
      let(:advertisement) do
        build(:advertisement,
              ad_title: Faker::String.random(length: 51..60))
      end

      it 'validates presence' do
        expect(advertisement).to_not be_valid
      end
    end
  end

  describe '#ad_text valid?' do
    context 'ad_text is nil' do
      let(:advertisement) { build(:advertisement, ad_text: '') }

      it 'validates presence' do
        expect(advertisement).to_not be_valid
      end
    end

    context 'ad_text is too short' do
      let(:advertisement) do
        build(:advertisement,
              ad_text: Faker::String.random(length: 1..99))
      end

      it 'validates presence' do
        expect(advertisement).to_not be_valid
      end
    end

    context 'ad_text is too long' do
      let(:advertisement) do
        build(:advertisement,
              ad_text: Faker::String.random(length: 1001..1010))
      end

      it 'validates presence' do
        expect(advertisement).to_not be_valid
      end
    end
  end

  describe '#category_id valid?' do
    context 'category_id is nil' do
      let(:advertisement) { build(:advertisement, category_id: '') }

      it 'validates presence' do
        expect(advertisement).to_not be_valid
      end
    end
  end
end
