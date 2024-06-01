# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SeriesPolicy, type: :policy do
  admin_series { described_class }

  let(:user) { create(:user) }
  let(:admin) { create(:user, admin: true) }
  let(:series) { create(:series) }

  describe 'for an admin user' do
    it 'grants access if user is an admin' do
      expect(admin_series.new(admin, series)).to be_create
    end

    it 'denies access if user is not an admin' do
      expect(admin_series.new(admin, series)).to be_update
    end
  end

  describe 'for a non-admin user' do
    it 'grants access if user is an admin' do
      expect(admin_series.new(user, series)).not_to be_create
    end

    it 'denies access if user is not an admin' do
      expect(admin_series.new(user, series)).not_to be_update
    end
  end
end
