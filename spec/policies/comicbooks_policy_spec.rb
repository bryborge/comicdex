# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ComicbooksPolicy, type: :policy do
  let(:user) { create(:user) }
  let(:admin) { create(:user, admin: true) }
  let(:series) { create(:series) }
  let(:comicbook) { create(:comicbook, series:) }

  shared_examples 'admin access' do
    it 'grants access to create a comicbook' do
      expect(described_class.new(admin, comicbook)).to be_create
    end

    it 'grants access to update a comicbook' do
      expect(described_class.new(admin, comicbook)).to be_update
    end
  end

  shared_examples 'non-admin access' do
    it 'denies access to create a comicbook' do
      expect(described_class.new(user, comicbook)).not_to be_create
    end

    it 'denies access to update a comicbook' do
      expect(described_class.new(user, comicbook)).not_to be_update
    end
  end

  describe 'for an admin user' do
    it_behaves_like 'admin access'
  end

  describe 'for a non-admin user' do
    it_behaves_like 'non-admin access'
  end
end
