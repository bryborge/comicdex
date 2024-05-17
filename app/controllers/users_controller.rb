# frozen_string_literal: true

# Users Controller
class UsersController < ApplicationController
  before_action :authenticate_user!

  def comics
    @user = current_user
    @comics = @user.comics
  end
end
