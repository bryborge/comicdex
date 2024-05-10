# frozen_string_literal: true

# Static web pages
class StaticPagesController < ApplicationController
  before_action :authenticate_user!

  def home; end
end
