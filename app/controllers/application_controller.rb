# frozen_string_literal: true

# Base Application
class ApplicationController < ActionController::Base
  include Pundit::Authorization
  before_action :authenticate_user!

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def user_not_authorized
    flash[:alert] = I18n.t('pundit.not_authorized')
    redirect_to(request.referer || root_path)
  end
end
