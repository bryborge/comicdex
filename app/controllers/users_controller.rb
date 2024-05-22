# frozen_string_literal: true

# Users Controller
class UsersController < ApplicationController
  # TODO: Make this a different url endpoint.  Perhaps ... "users/:id/collection" and display collection by series?
  def comicbooks
    @user = current_user
    @comics = @user.comicbooks
    @series = Series.find @comics.first.series_id if @comics.first
  end
end
