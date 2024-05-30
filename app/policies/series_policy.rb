# frozen_string_literal: true

# Series Policy
class SeriesPolicy < ApplicationPolicy
  attr_reader :user, :series

  def create?
    user.admin?
  end

  def update?
    user.admin?
  end
end
