# frozen_string_literal: true

# Users Controller
class UsersController < ApplicationController
  def comics
    @user = current_user
    @comics = @user.comics
  end
end
