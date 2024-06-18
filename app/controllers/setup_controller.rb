# frozen_string_literal: true

# First-time Setup Controller
class SetupController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :redirect_if_users_exist

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.admin = true

    if @user.save
      sign_in(@user) # Automatically sign in the new admin user
      redirect_to root_path, notice: I18n.t('notices.admin_user_created')
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :nickname)
  end

  def redirect_if_users_exist
    redirect_to root_path if User.exists?
  end
end
