# frozen_string_literal: true

# Series controller
class SeriesController < ApplicationController
  before_action :set_series, only: %i[show edit update destroy]
  before_action :set_user, only: %i[index show edit update destroy]

  def index
    @all_series = Series.all
  end

  def show
    @comics      = @series.comicbooks
    @user_comics = @user.comicbooks.where(series: @series)
  end

  def new
    @series = Series.new
    authorize @series
  end

  def edit
    authorize @series
  end

  def create
    @series = Series.new(series_params)
    authorize @series

    if @series.save
      redirect_to @series, notice: I18n.t('notices.series_created')
    else
      render :new
    end
  end

  def update
    authorize @series

    if @series.update(series_params)
      redirect_to @series, notice: I18n.t('notices.series_updated')
    else
      render :edit
    end
  end

  def destroy
    authorize @series

    @series.destroy
    redirect_to series_index_url, notice: I18n.t('notices.series_deleted')
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
    params.require(:series).permit(:name, :start_date, :end_date, :language, :synopsis, :series_image)
  end
end
