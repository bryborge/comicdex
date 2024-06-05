# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Comicbooks' do
  let(:user) { create(:user) }
  let(:admin) { create(:user, admin: true) }
  let(:series) { create(:series) }
  let!(:comicbook) { create(:comicbook, series_id: series.id) }
  let(:valid_attributes) { attributes_for(:comicbook).merge(series_id: series.id) }
  let(:invalid_attributes) do
    { title: '', format: nil, issue_number: '', volume_number: '', cover_price: '', cover_date: '', synopsis: '' }
  end

  describe 'GET /series/:series_id/comicbooks/:id' do
    before { sign_in user }

    context 'when the comicbook does not exist' do
      it 'responds with a 302 status' do
        get series_comicbook_path(series, id: -1)
        expect(response).to have_http_status(:found)
      end
    end

    context 'when the comicbook exists' do
      it 'responds successfully with an HTTP 200 status code' do
        get series_comicbook_path(series, comicbook)
        expect(response).to be_successful
        expect(response).to have_http_status(:ok)
      end

      it 'renders the show page' do
        get series_comicbook_path(series, comicbook)
        expect(response.body).to include(series.name)
      end
    end

    context 'when the user has collected the comicbook' do
      before do
        UserComicbook.create(user:, comicbook:) # Comicbook has been "collected" by the user
      end

      it 'displays the collected button' do
        get series_comicbook_path(series, comicbook)
        expect(response.body).to include('Collected')
      end
    end

    context 'when the user has not collected the comicbook' do
      it 'displays the collect button' do
        get series_comicbook_path(series, comicbook)
        expect(response.body).to include('Collect')
      end
    end
  end

  describe 'POST /create' do
    context 'when signed in as an admin' do
      before { sign_in admin }

      context 'with valid parameters' do
        it 'creates a new comicbook' do
          expect do
            post series_comicbooks_path(series), params: { comicbook: valid_attributes }
          end.to change(Comicbook, :count).by(1)
        end

        it 'redirects to the series' do
          post series_comicbooks_path(series), params: { comicbook: valid_attributes }
          expect(response).to redirect_to(series)
        end
      end

      context 'with invalid parameters' do
        it 'does not create a new comicbook' do
          expect do
            post series_comicbooks_path(series), params: { comicbook: invalid_attributes }
          end.not_to change(Comicbook, :count)
        end

        it 'renders the new template' do
          post series_comicbooks_path(series), params: { comicbook: invalid_attributes }
          expect(response.body).to include('- New Comic')
        end
      end
    end

    context 'when signed in as a non-admin user' do
      before { sign_in user }

      it 'redirects to the root path' do
        post series_comicbooks_path(series), params: { comicbook: valid_attributes }
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe 'PATCH /update/:id' do
    context 'when signed in as an admin' do
      before { sign_in admin }

      context 'with valid parameters' do
        let(:new_attributes) { { title: 'Updated Comicbook' } }

        it 'updates the comicbook' do
          patch series_comicbook_path(series, comicbook), params: { comicbook: new_attributes }
          comicbook.reload
          expect(comicbook.title).to eq('Updated Comicbook')
        end

        it 'redirects to the comicbook' do
          patch series_comicbook_path(series, comicbook), params: { comicbook: new_attributes }
          expect(response).to redirect_to(series_comicbook_path(series, comicbook))
        end
      end

      context 'with invalid parameters' do
        it 'renders the edit template' do
          patch series_comicbook_path(series, comicbook), params: { comicbook: invalid_attributes }
          expect(response.body).to include('General')
        end
      end
    end

    context 'when signed in as a non-admin user' do
      before { sign_in user }

      it 'redirects to the root path' do
        patch series_comicbook_path(series, comicbook), params: { comicbook: valid_attributes }
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe 'DELETE /destroy/:id' do
    context 'when signed in as an admin' do
      before { sign_in admin }

      it 'destroys the comicbook' do
        expect do
          delete series_comicbook_path(series, comicbook)
        end.to change(Comicbook, :count).by(-1)
      end

      it 'redirects to the series' do
        delete series_comicbook_path(series, comicbook)
        expect(response).to redirect_to(series)
      end
    end

    context 'when signed in as a non-admin user' do
      before { sign_in user }

      it 'does not destroy the comicbook' do
        expect do
          delete series_comicbook_path(series, comicbook)
        end.not_to change(Comicbook, :count)
      end

      it 'redirects to the root path' do
        delete series_comicbook_path(series, comicbook)
        expect(response).to redirect_to(root_path)
      end
    end
  end
end
