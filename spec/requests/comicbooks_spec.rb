# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Comicbooks' do
  let(:user) { create(:user) }
  let(:series) { create(:series) }
  let!(:comicbook) { create(:comicbook, series_id: series.id) }

  before do
    sign_in user
  end

  describe 'GET /comicbooks' do
    context 'when user is not authenticated' do
      before do
        sign_out user
      end

      it 'redirects to the login page' do
        get comicbooks_path
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context 'when user is authenticated' do
      let!(:comicbooks) { create_list(:comicbook, 2, series_id: series.id) }

      it 'responds successfully with an HTTP 200 status code' do
        get comicbooks_path
        expect(response).to be_successful
        expect(response).to have_http_status(:ok)
      end

      it 'renders the index template' do
        get comicbooks_path
        comicbooks.each do |comicbook|
          expect(response.body).to include(comicbook.series.name)
        end
      end
    end
  end

  describe 'GET /comicbooks/:id' do
    context 'when the comicbook does not exist' do
      it 'responds with a 302 status' do
        get comicbook_path(id: -1)
        expect(response).to have_http_status(:found)
      end
    end

    context 'when the comicbook exists' do
      it 'responds successfully with an HTTP 200 status code' do
        get comicbook_path(comicbook)
        expect(response).to be_successful
        expect(response).to have_http_status(:ok)
      end

      it 'renders the show page' do
        get comicbook_path(comicbook)
        expect(response.body).to include(series.name)
      end
    end

    context 'when the user has collected the comicbook' do
      before do
        UserComicbook.create(user:, comicbook:) # Comicbook has been "collected" by the user
      end

      it 'displays the collected button' do
        get comicbook_path(comicbook)
        expect(response.body).to include('Collected')
      end
    end

    context 'when the user has not collected the comicbook' do
      it 'displays the collect button' do
        get comicbook_path(comicbook)
        expect(response.body).to include('Collect')
      end
    end
  end
end
