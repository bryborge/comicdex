# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'User' do
  let(:user) { create(:user) }

  describe 'validations' do
    it 'is valid with a nickname, email, and password' do
      expect(user).to be_valid
    end

    it 'is invalid without a nickname' do
      user.nickname = nil
      expect(user).not_to be_valid
      expect(user.errors[:nickname]).to include("can't be blank")
    end

    it 'is invalid without an email' do
      user.email = nil
      expect(user).not_to be_valid
      expect(user.errors[:email]).to include("can't be blank")
    end

    it 'is invalid with a duplicate email' do
      create(:user, email: 'johndoe@example.com')
      user = build(:user, email: 'johndoe@example.com')
      expect(user).not_to be_valid
      expect(user.errors[:email]).to include('has already been taken')
    end

    it 'is invalid with a password that is too short' do
      user.password = 'pass'
      expect(user).not_to be_valid
      expect(user.errors[:password]).to include('is too short (minimum is 6 characters)')
    end
  end
end
