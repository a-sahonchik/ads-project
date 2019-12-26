# frozen_string_literal: true

require 'spec_helper'
require 'cancan/matchers'

describe 'Roles' do
  subject(:ability) { Ability.new(user) }
  let(:user) { create(:user) }

  describe 'Admin' do
    before :each do
      user.add_role(:admin)
    end

    it 'Can read all' do
      expect(subject).to be_able_to(:read, :all)
    end

    it 'Can destroy advertisements' do
      expect(subject).to be_able_to(:destroy, Advertisement.new)
    end

    it 'Can can manage opened advertisements' do
      expect(subject).to be_able_to(:manage, Advertisement, :opened_advertisements)
    end

    it 'Can manage users' do
      expect(subject).to be_able_to(:manage, User.new)
    end

    it 'Can manage categories' do
      expect(subject).to be_able_to(:manage, Category.new)
    end

    it 'Cannot create advertisements' do
      expect(subject).to_not be_able_to(:create, Advertisement.new)
    end
  end

  describe 'User' do
    before :each do
      user.add_role(:user)
    end

    it 'Can read advertisements' do
      expect(subject).to be_able_to(:read, Advertisement.new)
    end

    it "Can view user's pages" do
      expect(subject).to be_able_to(:show, User.new)
    end

    it 'Can view categories' do
      expect(subject).to be_able_to(:show, Category.new)
    end

    it 'Can manage own advertisements' do
      expect(subject).to be_able_to(:manage, Advertisement, user_id: user.id)
    end

    it 'Cannot update advertisements with some states' do
      expect(subject).to_not be_able_to(:update, Advertisement.where(state: %w[opened rejected approved published archived]))
    end

    it 'Cannot view opened advertisements' do
      expect(subject).to be_able_to(:show, Advertisement, :opened_advertisements)
    end

    it 'Can destroy own advertisements' do
      expect(subject).to be_able_to(:destroy, Advertisement, user_id: user.id)
    end
  end

  describe 'Guest' do
    before :each do
      user.remove_role(:user)
      user.remove_role(:admin)
    end

    it 'Can read advertisements' do
      expect(subject).to be_able_to(:read, Advertisement.new)
    end

    it "Can view user's pages" do
      expect(subject).to be_able_to(:show, User.new)
    end

    it 'Can view categories' do
      expect(subject).to be_able_to(:show, Category.new)
    end
  end
end
