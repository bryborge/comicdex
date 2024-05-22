# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Comicbook' do
  let(:series) { create(:series) }

  describe 'validations' do
    it 'is valid with a format' do
      comicbook = Comicbook.new(format: 'issue', series:)
      expect(comicbook).to be_valid
    end

    it 'is invalid without a format' do
      comicbook = Comicbook.new(format: nil)
      expect(comicbook).not_to be_valid
      expect(comicbook.errors[:format]).to include("can't be blank")
    end
  end
end
