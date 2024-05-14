# frozen_string_literal: true

module Users
  # User Profile
  class ProfilesController < ApplicationController
    before_action :authenticate_user!

    def show; end

    def edit
      @user = current_user
    end

    def update
      @user = current_user
      if @user.update(user_params)
        redirect_to users_profile_path, notice: I18n.t('notices.user_updated')
      else
        render :edit
      end
    end

    private

    def user_params
      params.require(:user).permit(:nickname)
    end
  end
end
