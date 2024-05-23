# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'User' do
  let(:user) { create(:user) }

  describe 'associations' do
    it 'has many user_comicbooks with dependent destroy' do
      user = create(:user)
      series = create(:series)
      comicbook1 = create(:comicbook, series:)
      comicbook2 = create(:comicbook, series:)

      user_comicbook1 = UserComicbook.create!(user:, comicbook: comicbook1)
      user_comicbook2 = UserComicbook.create!(user:, comicbook: comicbook2)

      expect(user.user_comicbooks).to include(user_comicbook1, user_comicbook2)

      user.destroy
      expect(UserComicbook.where(id: [user_comicbook1.id, user_comicbook2.id])).to be_empty
    end

    it 'has many comicbooks through user_comicbooks' do
      user = create(:user)
      series = create(:series)
      comicbook1 = create(:comicbook, series:)
      comicbook2 = create(:comicbook, series:)

      UserComicbook.create!(user:, comicbook: comicbook1)
      UserComicbook.create!(user:, comicbook: comicbook2)

      expect(user.comicbooks).to include(comicbook1, comicbook2)
    end

    it 'has many series through comicbooks' do
      user = create(:user)
      series1 = create(:series)
      series2 = create(:series)
      comicbook1 = create(:comicbook, series: series1)
      comicbook2 = create(:comicbook, series: series2)

      UserComicbook.create!(user:, comicbook: comicbook1)
      UserComicbook.create!(user:, comicbook: comicbook2)

      expect(user.series).to include(series1, series2)
    end
  end

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
