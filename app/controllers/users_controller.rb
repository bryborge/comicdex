# frozen_string_literal: true

# Users Controller
class UsersController < ApplicationController
  def comicbooks
    @user = current_user
    @comics = @user.comicbooks
  end
end
