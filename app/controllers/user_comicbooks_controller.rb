# frozen_string_literal: true

# User Comicbooks controller (the user's collection of comicbooks)
class UserComicbooksController < ApplicationController
  def create
    @user = User.find(params[:user_id])
    @comic = Comicbook.find(params[:comic_id])
    @user.comicbooks << @comic

    redirect_to comicbook_path(@comic), notice: I18n.t('notices.comicbook_added_to_user_collection')
  end

  def destroy
    @user = User.find(params[:user_id])
    @comic = Comicbook.find(params[:comic_id])
    @user.comicbooks.delete(@comic)

    redirect_to comicbook_path(@comic), notice: I18n.t('notices.comicbook_removed_from_user_collection')
  end
end
