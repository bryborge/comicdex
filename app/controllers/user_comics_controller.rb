# frozen_string_literal: true

# User Comics controller (the user's collection of comic books)
class UserComicsController < ApplicationController
  def create
    @user = User.find(params[:user_id])
    @comic = Comic.find(params[:comic_id])
    @user.comics << @comic

    redirect_to comics_user_path(@user), notice: I18n.t('notices.comic_added_to_user_collection')
  end
end
