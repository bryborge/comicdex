# frozen_string_literal: true

# Series controller
class SeriesController < ApplicationController
  before_action :set_series, only: %i[show]

  def index
    @all_series = Series.all
  end

  def show
    @comics = @series.comicbooks
  end

  private

  def set_series
    @series = Series.find_by(id: params[:id])

    return if @series

    redirect_to series_url, alert: I18n.t('alerts.series_not_found')
  end
end
