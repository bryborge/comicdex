# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Series' do
  let(:user) { create(:user) }
  let(:admin) { create(:user, admin: true) }
  let!(:series) { create(:series) }
  let(:comicbook) { create(:comicbook, entity_number: '1', series:) }
  let(:valid_attributes) { attributes_for(:series) }
  let(:invalid_attributes) { { name: '', start_date: '', end_date: '', language: '', synopsis: '' } }

  describe 'GET /series' do
    before { sign_in user }

    it 'returns a successful response' do
      get series_index_path
      expect(response).to be_successful
    end

    it 'includes all series in the response body' do
      create(:series, name: 'Series 1')
      create(:series, name: 'Series 2')
      get series_index_path
      expect(response.body).to include('Series 1', 'Series 2')
    end
  end

  describe 'GET /series/:id' do
    before { sign_in user }

    context 'when series exists' do
      it 'returns a successful response' do
        get series_path(series)
        expect(response).to be_successful
      end

      it 'includes the series name in the response body' do
        get series_path(series)
        expect(response.body).to include(series.name)
      end

      it 'includes the series comicbooks in the response body' do
        create(:comicbook, entity_number: '1', series:)
        create(:comicbook, entity_number: '2', series:)
        get series_path(series)
        expect(response.body).to include("#{series.name} #1", "#{series.name} #2")
      end

      it "includes the user's comicbooks in the series in the response body" do
        UserComicbook.create!(user:, comicbook:)
        UserComicbook.create!(user:, comicbook: create(:comicbook, entity_number: '2', series:))
        get series_path(series)
        expect(response.body).to include(series.name, '#2')
      end
    end

    context 'when series does not exist' do
      it 'redirects to the index with an alert' do
        get series_path(id: 'nonexistent')
        expect(response).to redirect_to(series_index_path)
        follow_redirect!
        expect(response.body).to include(I18n.t('alerts.series_not_found'))
      end
    end
  end

  describe 'GET /series/new' do
    context 'when signed in as an admin' do
      before { sign_in admin }

      it 'returns a successful response' do
        get new_series_path
        expect(response).to be_successful
      end
    end

    context 'when signed in as a non-admin user' do
      before { sign_in user }

      it 'redirects to the root path' do
        get new_series_path
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe 'GET /series/:id/edit' do
    context 'when signed in as an admin' do
      before { sign_in admin }

      it 'returns a successful response' do
        get edit_series_path(series)
        expect(response).to be_successful
      end
    end

    context 'when signed in as a non-admin user' do
      before { sign_in user }

      it 'redirects to the root path' do
        get edit_series_path(series)
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe 'POST series/create' do
    context 'when signed in as an admin' do
      before { sign_in admin }

      context 'with valid parameters' do
        it 'creates a new series' do
          expect do
            post series_index_path, params: { series: valid_attributes }
          end.to change(Series, :count).by(1)
        end

        it 'redirects to the created series' do
          post series_index_path, params: { series: valid_attributes }
          expect(response).to redirect_to(Series.last)
        end
      end

      context 'with invalid parameters' do
        it 'does not create a new series' do
          expect do
            post series_index_path, params: { series: invalid_attributes }
          end.not_to change(Series, :count)
        end

        it 'renders the new template' do
          post series_index_path, params: { series: invalid_attributes }
          expect(response.body).to include('New Comic Series')
        end
      end
    end

    context 'when signed in as a non-admin user' do
      before { sign_in user }

      it 'redirects to the root path' do
        post series_index_path, params: { series: valid_attributes }
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe 'PATCH /series/:id/update' do
    context 'when signed in as an admin' do
      before { sign_in admin }

      context 'with valid parameters' do
        let(:new_attributes) { { name: 'Updated Series' } }

        it 'updates the series' do
          patch series_path(series), params: { series: new_attributes }
          series.reload
          expect(series.name).to eq('Updated Series')
        end

        it 'redirects to the series' do
          patch series_path(series), params: { series: new_attributes }
          expect(response).to redirect_to(series)
        end
      end

      context 'with invalid parameters' do
        it 'renders the edit template' do
          patch series_path(series), params: { series: invalid_attributes }
          expect(response.body).to include('General')
        end
      end
    end

    context 'when signed in as a non-admin user' do
      before { sign_in user }

      it 'redirects to the root path' do
        patch series_path(series), params: { series: valid_attributes }
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe 'DELETE /destroy/:id' do
    context 'when signed in as an admin' do
      before { sign_in admin }

      it 'destroys the series' do
        expect do
          delete series_path(series)
        end.to change(Series, :count).by(-1)
      end

      it 'redirects to the series index' do
        delete series_path(series)
        expect(response).to redirect_to(series_index_path)
      end
    end

    context 'when signed in as a non-admin user' do
      before { sign_in user }

      it 'does not destroy the series' do
        expect do
          delete series_path(series)
        end.not_to change(Series, :count)
      end

      it 'redirects to the root path' do
        delete series_path(series)
        expect(response).to redirect_to(root_path)
      end
    end
  end
end
