# frozen_string_literal: true

# Comicbooks controller
class ComicbooksController < ApplicationController
  before_action :set_comicbook, only: %i[show edit update destroy]
  before_action :set_series
  before_action :set_user, only: %i[show edit update destroy]

  def show
    @series      = @comic.series
    @user_comics = @user.comicbooks.pluck(:id)
  end

  def new
    @comic = @series.comicbooks.build
    authorize @comic
  end

  def edit
    authorize @comic
    @series = @comic.series
  end

  def create
    @comic  = @series.comicbooks.build(comicbook_params)

    authorize @comic

    if @comic.save
      redirect_to @series, notice: I18n.t('notices.comicbook_created')
    else
      render :new
    end
  end

  def update
    authorize @comic

    if @comic.update(comicbook_params)
      redirect_to series_comicbook_path(@series, @comic), notice: I18n.t('notices.comicbook_updated')
    else
      render :edit
    end
  end

  def destroy
    authorize @comic

    @series = @comic.series
    redirect_to @series, notice: I18n.t('notices.comicbook_deleted') if @comic.destroy
  end

  private

  def set_comicbook
    @comic = Comicbook.find_by(id: params[:id])

    return if @comic

    redirect_to series_index_url, alert: I18n.t('alerts.comicbook_not_found')
  end

  def set_series
    @series = Series.find_by(id: params[:series_id])
  end

  def set_user
    @user = current_user
  end

  def comicbook_params
    params.require(:comicbook).permit(:title, :format, :entity_number, :cover_price, :cover_date, :synopsis,
                                      :cover_image)
  end
end
