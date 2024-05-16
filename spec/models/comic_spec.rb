# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Comic' do
  describe 'validations' do
    it 'is valid with a title' do
      comic = Comic.new(title: 'The Amazing Spider-Man')
      expect(comic).to be_valid
    end

    it 'is invalid without a title' do
      comic = Comic.new(title: nil)
      expect(comic).not_to be_valid
      expect(comic.errors[:title]).to include("can't be blank")
    end
  end
end
