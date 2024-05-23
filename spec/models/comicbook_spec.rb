# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Comicbook' do
  let(:series) { create(:series) }

  describe 'associations' do
    it 'has many user_comicbooks with dependent destroy' do
      comicbook = create(:comicbook, series:)
      user1 = create(:user)
      user2 = create(:user)

      user_comicbook1 = UserComicbook.create!(user: user1, comicbook:)
      user_comicbook2 = UserComicbook.create!(user: user2, comicbook:)

      expect(comicbook.user_comicbooks).to include(user_comicbook1, user_comicbook2)

      comicbook.destroy
      expect(UserComicbook.where(id: [user_comicbook1.id, user_comicbook2.id])).to be_empty
    end

    it 'has many users through user_comicbooks' do
      comicbook = create(:comicbook, series:)
      user1 = create(:user)
      user2 = create(:user)

      UserComicbook.create!(user: user1, comicbook:)
      UserComicbook.create!(user: user2, comicbook:)

      expect(comicbook.users).to include(user1, user2)
    end

    it 'belongs to a series' do
      comicbook = create(:comicbook, series:)

      expect(comicbook.series).to eq(series)
    end
  end

  describe 'validations' do
    it 'is valid with valid attributes' do
      comicbook = build(:comicbook, series:)
      expect(comicbook).to be_valid
    end

    it 'is not valid without a format' do
      comicbook = build(:comicbook, format: nil, series:)
      expect(comicbook).not_to be_valid
      expect(comicbook.errors[:format]).to include("can't be blank")
    end
  end
end
