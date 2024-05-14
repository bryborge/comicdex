# frozen_string_literal: true

# Base Application
class ApplicationController < ActionController::Base
  before_action :authenticate_user!
end
