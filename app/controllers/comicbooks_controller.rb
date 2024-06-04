# frozen_string_literal: true

# Comicbooks controller
class ComicbooksController < ApplicationController
  before_action :set_comicbook, only: %i[show]
  before_action :set_user, only: %i[show]

  def show
    @series      = @comic.series
    @user_comics = @user.comicbooks.pluck(:id)
  end

  private

  def set_comicbook
    @comic = Comicbook.find_by(id: params[:id])

    return if @comic

    redirect_to series_index_url, alert: I18n.t('alerts.comicbook_not_found')
  end

  def set_user
    @user = current_user
  end
end
