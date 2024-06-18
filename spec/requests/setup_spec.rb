# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'First-time Setup' do
  before do
    User.delete_all
  end

  describe 'GET /setup' do
    context 'when no users exist' do
      it 'returns http success and displays the setup form' do
        get setup_path
        expect(response).to have_http_status(:success)
        expect(response.body).to include('Create Admin User')
      end
    end

    context 'when users exist' do
      before { create(:user) }

      it 'redirects to the root path' do
        get setup_path
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe 'POST /setup' do
    let(:valid_attributes) do
      {
        user: {
          email: 'admin@example.com',
          password: 'password',
          password_confirmation: 'password',
          nickname: 'Admin'
        }
      }
    end

    let(:invalid_attributes) do
      {
        user: {
          email: '',
          password: 'password',
          password_confirmation: 'password',
          nickname: 'Admin'
        }
      }
    end

    context 'when no users exist' do
      it 'creates an admin user and redirects to the root path' do
        post setup_path, params: valid_attributes
        expect(response).to redirect_to(root_path)
        follow_redirect!
        expect(response.body).to include(I18n.t('notices.admin_user_created'))
        expect(User.count).to eq(1)
        expect(User.first).to be_admin
      end

      it 'displays errors with invalid attributes' do
        post setup_path, params: invalid_attributes
        expect(response.body).to include('Create Admin User')
        expect(response.body).to include('can&#39;t be blank')
        expect(User.count).to eq(0)
      end
    end

    context 'when users exist' do
      let(:user) { create(:user) }

      it 'redirects to the root path' do
        post setup_path, params: valid_attributes
        expect(response).to redirect_to(root_path)
        expect(User.count).to eq(1) # Only the pre-existing user
      end
    end
  end

  describe 'Redirect to Setup' do
    context 'when no users exist' do
      it 'redirects to setup path' do
        get root_path
        expect(response).to redirect_to(setup_path)
      end
    end

    context 'when users exist' do
      let(:user) { create(:user) }

      it 'does not redirect to setup path' do
        sign_in user
        get root_path
        expect(response).to have_http_status(:success)
      end
    end
  end
end
