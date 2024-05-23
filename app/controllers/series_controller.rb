# frozen_string_literal: true

# Series controller
class SeriesController < ApplicationController
  before_action :set_series, only: %i[show]
  before_action :set_user, only: %i[show]

  def index
    @all_series = Series.all
  end

  def show
    @comics      = @series.comicbooks
    @user_comics = @user.comicbooks.where(series: @series)
  end

  def new
    @series = Series.new
  end

  def create
    @series = Series.new(series_params)

    if @series.save
      redirect_to @series, notice: I18n.t('alerts.series_created')
    else
      render :new
    end
  end

  private

  def set_series
    @series = Series.find_by(id: params[:id])

    return if @series

    redirect_to series_index_url, alert: I18n.t('alerts.series_not_found')
  end

  def set_user
    @user = current_user
  end

  def series_params
    params.require(:series).permit(:name, :start_date, :end_date)
  end
end
