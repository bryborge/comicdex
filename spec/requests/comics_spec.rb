# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Comics' do
  let(:user) { create(:user) }
  let!(:comic) { create(:comic) }

  before do
    sign_in user
  end

  describe 'GET /comics' do
    context 'when user is not authenticated' do
      before do
        sign_out user
      end

      it 'redirects to the login page' do
        get comics_path
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context 'when user is authenticated' do
      let!(:comics) { create_list(:comic, 2) }

      it 'responds successfully with an HTTP 200 status code' do
        get comics_path
        expect(response).to be_successful
        expect(response).to have_http_status(:ok)
      end

      it 'renders the index template' do
        get comics_path
        comics.each do |comic|
          expect(response.body).to include(comic.title)
        end
      end
    end
  end

  describe 'GET /comics/:id' do
    context 'when the comic does not exist' do
      it 'responds with a 302 status' do
        get comic_path(id: -1)
        expect(response).to have_http_status(:found)
      end
    end

    context 'when the comic exists' do
      it 'responds successfully with an HTTP 200 status code' do
        get comic_path(comic)
        expect(response).to be_successful
        expect(response).to have_http_status(:ok)
      end

      it 'renders the show page' do
        get comic_path(comic)
        expect(response.body).to include(comic.title)
      end
    end

    context 'when the user has collected the comic' do
      before do
        UsersComic.create(user:, comic:) # Comic has been "collected" by the user
      end

      it 'displays the collected button' do
        get comic_path(comic)
        expect(response.body).to include('Collected')
      end
    end

    context 'when the user has not collected the comic' do
      it 'displays the collect button' do
        get comic_path(comic)
        expect(response.body).to include('Collect')
      end
    end
  end
end
