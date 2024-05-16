# frozen_string_literal: true

# Comics controller
class ComicsController < ApplicationController
  before_action :set_comic, only: %i[show]

  def index
    @comics = Comic.all
  end

  def show; end

  private

  def set_comic
    @comic = Comic.find_by(id: params[:id])

    return if @comic

    redirect_to comics_url, alert: I18n.t('alerts.comic_not_found')
  end
end
