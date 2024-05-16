# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users' do
  let(:user) { create(:user) }

  before do
    sign_in user
  end

  # User > Settings > Public Profile Page
  describe 'GET /users/profile/edit' do
    context 'when user is not authenticated' do
      before do
        sign_out user
      end

      it 'redirects to the login page' do
        get edit_users_profile_path
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context 'when user is authenticated' do
      it 'responds successfully with an HTTP 200 status code' do
        get edit_users_profile_path
        expect(response).to be_successful
        expect(response).to have_http_status(:ok)
      end

      it 'renders the template' do
        get edit_users_profile_path
        expect(response.body).to include(user.nickname)
      end
    end
  end

  describe 'PATCH /users/profile' do
    context 'when the user is not authenticated' do
      it 'redirects to the login page' do
        sign_out user

        patch users_profile_path, params: { user: { nickname: 'newnickname' } }
        expect(response).to have_http_status(:redirect)
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context 'when the user is authenticated' do
      it 'updates the user and redirects to the profile page' do
        sign_in user

        patch users_profile_path, params: { user: { nickname: 'newnickname' } }
        expect(response).to have_http_status(:redirect)
        expect(response).to redirect_to(users_profile_path)
        expect(user.reload.nickname).to eq('newnickname')
      end

      it 'renders the edit template when the update fails' do
        sign_in user

        patch users_profile_path, params: { user: { nickname: nil } }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.body).to include('can&#39;t be blank')
      end
    end
  end

  # User > Settings > Account Page
  describe 'GET /users/edit' do
    context 'when the user is not authenticated' do
      it 'redirects to the login page' do
        sign_out user

        get edit_user_registration_path
        expect(response).to have_http_status(:redirect)
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context 'when the user is authenticated' do
      it 'renders the edit template' do
        sign_in user

        get edit_user_registration_path
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe 'PATCH /users' do
    context 'when the user is authenticated' do
      it "updates the user's email and redirects to the home page" do
        sign_in user

        patch user_registration_path, params: { user: { email: 'newemail@example.com', current_password: 'password' } }
        expect(response).to have_http_status(:redirect)
        expect(response).to redirect_to(root_path)
        expect(user.reload.email).to eq('newemail@example.com')
      end

      it 'renders the edit template when the update fails' do
        sign_in user

        patch user_registration_path, params: { user: { email: nil } }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'when the user is not authenticated' do
      it 'redirects to the login page' do
        sign_out user

        patch user_registration_path, params: { user: { email: 'newemail@example.com', current_password: 'password' } }
        expect(response).to have_http_status(:redirect)
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  # "Your Profile"
  describe 'GET /users/profile' do
    context 'when user is not authenticated' do
      before do
        sign_out user
      end

      it 'redirects to the login page' do
        get users_profile_path
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context 'when user is authenticated' do
      it 'responds successfully with an HTTP 200 status code' do
        get users_profile_path
        expect(response).to be_successful
        expect(response).to have_http_status(:ok)
      end

      it 'renders the template' do
        get users_profile_path
        expect(response.body).to include(user.nickname)
      end
    end
  end
end
