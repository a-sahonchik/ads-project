# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Category, type: :model do
  describe '#factory' do
    it 'is valid' do
      expect(build(:category)).to be_valid
    end
  end

  describe '#valid?' do
    context 'name is nil' do
      let(:category) { build(:category, name: '') }

      it 'validates presence' do
        expect(category).to_not be_valid
      end
    end

    context 'name is too short' do
      let(:category) do
        build(:category,
              name: Faker::String.random(length: 1..2))
      end

      it 'validates presence' do
        expect(category).to_not be_valid
      end
    end

    context 'name is too long' do
      let(:category) do
        build(:category,
              name: Faker::String.random(length: 21..30))
      end

      it 'validates presence' do
        expect(category).to_not be_valid
      end
    end
  end
end
