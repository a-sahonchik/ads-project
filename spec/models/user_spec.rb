require 'rails_helper'

RSpec.describe User, type:  :model  do

  describe '#factory' do
    it 'is valid' do
      expect(build(:user)).to be_valid
    end
  end

  describe '#valid?' do
    context 'email is nil' do
      let(:user) { build(:user, email: '') }

      it 'validates presence' do
        expect(user).to_not be_valid
      end
    end

    context 'password is nil' do
      let(:user) { build(:user, password: '') }

      it 'validates presence' do
        expect(user).to_not be_valid
      end
    end

    context 'username is nil' do
      let(:user) { build(:user, username: '') }

      it 'validates presence' do
        expect(user).to_not be_valid
      end
    end
  end

  describe '#admin?' do
    let(:user) { build(:user) }

    it "has admin rights" do
      user.add_role :admin
      expect(user.has_role? :admin).to be true
    end

    it "has no user rights" do
      expect(user.has_role? :user).to be false
    end
  end

  describe '#user?' do
    let(:user) { build(:user) }

    it "has user rights" do
      user.add_role :user
      expect(user.has_role? :user).to be true
    end

    it "has no admin rights" do
      expect(user.has_role? :admin).to be false
    end
  end

  describe '#assign_default_role' do
    let(:user) { build(:user) }

    it "add role :user if role is blank" do

      if user.roles.blank?
       user.add_role :user
       expect(user.has_role? :user).to be true
       expect(user.has_role? :admin).to be false
      end
    end
  end

end
