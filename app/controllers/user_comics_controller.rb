# frozen_string_literal: true

# User Comics controller (the user's collection of comic books)
class UserComicsController < ApplicationController
  def create
    @user = User.find(params[:user_id])
    @comic = Comic.find(params[:comic_id])
    @user.comics << @comic

    redirect_to comic_path(@comic), notice: I18n.t('notices.comic_added_to_user_collection')
  end

  def destroy
    @user = User.find(params[:user_id])
    @comic = Comic.find(params[:comic_id])
    @user.comics.delete(@comic)

    redirect_to comic_path(@comic), notice: I18n.t('notices.comic_removed_from_user_collection')
  end
end
