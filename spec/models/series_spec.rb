# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Series do
  describe 'associations' do
    it 'has many comicbooks with dependent destroy' do
      series = create(:series)
      comicbook1 = create(:comicbook, series:)
      comicbook2 = create(:comicbook, series:)

      expect(series.comicbooks).to include(comicbook1, comicbook2)

      series.destroy
      expect(Comicbook.where(id: [comicbook1.id, comicbook2.id])).to be_empty
    end
  end

  describe 'validations' do
    it 'is valid with valid attributes' do
      series = build(:series, name: 'Valid Series')
      expect(series).to be_valid
    end

    it 'is not valid without a name' do
      series = build(:series, name: nil)
      expect(series).not_to be_valid
      expect(series.errors[:name]).to include("can't be blank")
    end
  end
end
