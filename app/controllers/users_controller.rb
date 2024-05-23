# frozen_string_literal: true

# Users Controller
class UsersController < ApplicationController
  before_action :set_user, only: %i[collection]

  def collection
    @unique_series = @user.series
  end

  private

  def set_user
    @user = current_user
  end
end
