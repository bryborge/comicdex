# frozen_string_literal: true

# Base Application
class ApplicationController < ActionController::Base
  before_action :redirect_to_setup_if_no_users
  before_action :authenticate_user!

  include Pundit::Authorization

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def redirect_to_setup_if_no_users
    return unless User.count.zero? && !request.path.start_with?('/setup')

    redirect_to setup_path
  end

  def user_not_authorized
    flash[:alert] = I18n.t('pundit.not_authorized')
    redirect_to(request.referer || root_path)
  end
end
