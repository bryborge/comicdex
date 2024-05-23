# frozen_string_literal: true

# User Comicbooks controller (the user's collection of comicbooks)
class UserComicbooksController < ApplicationController
  before_action :set_user, only: %i[create destroy]
  before_action :set_comicbook, only: %i[create destroy]

  def create
    @user.comicbooks << @comic

    redirect_to series_comicbook_path(@comic.series_id, @comic),
                notice: I18n.t('notices.comicbook_added_to_user_collection')
  end

  def destroy
    @user.comicbooks.delete(@comic)

    redirect_to series_comicbook_path(@comic.series_id, @comic),
                notice: I18n.t('notices.comicbook_removed_from_user_collection')
  end

  private

  def set_comicbook
    @comic = Comicbook.find(params[:comic_id])
  end

  def set_user
    @user = current_user
  end
end
