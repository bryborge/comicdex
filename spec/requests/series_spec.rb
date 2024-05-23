# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Series' do
  let(:user) { create(:user) }
  let(:series) { create(:series) }
  let(:comicbook) { create(:comicbook, issue_number: '1', series:) }

  before do
    sign_in user
  end

  describe 'GET #index' do
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

  describe 'GET #show' do
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
        create(:comicbook, issue_number: '1', series:)
        create(:comicbook, issue_number: '2', series:)
        get series_path(series)
        expect(response.body).to include("#{series.name} #1", "#{series.name} #2")
      end

      it "includes the user's comicbooks in the series in the response body" do
        UserComicbook.create!(user:, comicbook:)
        UserComicbook.create!(user:, comicbook: create(:comicbook, issue_number: '2', series:))
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
end
